#!/usr/bin/env bash
# dev-setup.sh
# =============================================
# Project bootstrap script – uv + robust pre-commit + OpenTofu focus
# Simplified tool installation: snap where possible (Ubuntu), binary for yamlfmt
# Created: February 2026

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly TOOLS_DIR="${PROJECT_ROOT}/.tools/bin"

# ── Colors ─────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# ── Utilities ──────────────────────────────────
log_info()  { printf "${GREEN}INFO:  %s${NC}\n" "$*"; }
log_warn()  { printf "${YELLOW}WARN:  %s${NC}\n" "$*" >&2; }
log_error() { printf "${RED}ERROR: %s${NC}\n" "$*" >&2; exit 1; }

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

retry_cmd() {
    local cmd="$1"
    local max=3
    local i=1
    while (( i <= max )); do
        log_info "Attempt $i/$max: $cmd"
        if eval "$cmd"; then
            return 0
        fi
        log_warn "Attempt $i failed — retrying in 3s..."
        sleep 3
        ((i++))
    done
    log_error "Command failed after $max attempts: $cmd"
}

ensure_snapd() {
    if ! command_exists snap; then
        log_info "Installing snapd..."
        sudo apt update -y
        sudo apt install -y snapd
        sudo snap install core || true
        sleep 5  # give snapd time to initialize
    fi
}

install_snap_tool() {
    local snap_name="$1"
    local binary_name="${2:-$snap_name}"

    if command_exists "$binary_name"; then
        log_info "$binary_name already available — skipping snap install"
        return 0
    fi

    log_info "Installing $snap_name via snap..."
    sudo snap install "$snap_name" --classic || log_error "snap install $snap_name failed"
    log_info "$binary_name installed via snap"
}

install_yamlfmt_binary() {
    local binary_name="yamlfmt"
    local tool_path="${TOOLS_DIR}/${binary_name}"

    if [[ -x "$tool_path" ]]; then
        log_info "yamlfmt already installed at $tool_path — skipping"
        return 0
    fi

    log_info "Installing yamlfmt via official binary (no maintained snap)"

    local json
    json=$(curl -sSf "https://api.github.com/repos/google/yamlfmt/releases/latest") ||
        log_error "Failed to fetch yamlfmt release info"

    local tag
    tag=$(echo "$json" | grep -oP '"tag_name":\s*"\K[^"]+' | head -1)
    [[ -z "$tag" ]] && log_error "Could not parse yamlfmt tag"

    local version="${tag#v}"
    local arch_raw="$(uname -m)"
    local y_arch="x86_64"
    [[ "$arch_raw" == "aarch64" || "$arch_raw" == "arm64" ]] && y_arch="arm64"

    local filename="yamlfmt_${version}_Linux_${y_arch}.tar.gz"
    local url="https://github.com/google/yamlfmt/releases/download/${tag}/${filename}"

    local temp_dir=$(mktemp -d)
    trap 'rm -rf "$temp_dir"' EXIT

    retry_cmd "curl -L --fail \"$url\" -o \"$temp_dir/$filename\""

    tar -xzf "$temp_dir/$filename" -C "$temp_dir" ||
        log_error "Failed to extract yamlfmt"

    mkdir -p "$TOOLS_DIR"
    mv "$temp_dir/yamlfmt" "$tool_path"
    chmod +x "$tool_path"

    log_info "yamlfmt $tag → $tool_path"
}

# ── Install & configure pre-commit with uv ─────
install_and_setup_precommit() {
    log_info "Setting up pre-commit hooks using uv..."

    # Auto-install uv if missing — no exit on failure, just warn and continue
    if ! command_exists uv; then
        log_info "uv not found — installing automatically via official installer..."

        if ! curl -LsSf https://astral.sh/uv/install.sh | sh; then
            log_warn "uv installation attempt failed — continuing anyway (pre-commit may fail if uv is still missing)"
            log_warn "You can retry manually later: curl -LsSf https://astral.sh/uv/install.sh | sh"
        else
            log_info "uv installation command ran successfully"
        fi

        # Aggressive PATH refresh attempts
        for profile in "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.cargo/env"; do
            [[ -f "$profile" ]] && source "$profile" 2>/dev/null || true
        done

        # Check again after install + sourcing
        if command_exists uv; then
            log_info "uv is now available ($(uv --version))"
        else
            log_warn "uv was installed but is not yet in PATH in this shell session."
            log_warn "To fix immediately in this terminal run:"
            log_warn "  export PATH=\"\$HOME/.local/bin:\$PATH\""
            log_warn "Or open a new terminal and re-run the script."
            # We do NOT exit — proceed to try using uv anyway (worst case user fixes PATH after)
        fi
    fi

    # Install / upgrade pre-commit
    if command_exists pre-commit; then
        local current_version
        current_version=$(pre-commit --version 2>/dev/null | cut -d' ' -f2 || echo "unknown")
        log_info "pre-commit found (v${current_version}) — upgrading..."
        uv tool upgrade pre-commit 2>/dev/null || log_warn "pre-commit upgrade failed — continuing"
    else
        log_info "Installing pre-commit via uv..."
        uv tool install pre-commit || log_warn "pre-commit install failed — continuing (may need PATH fix)"
    fi

    if ! command_exists pre-commit; then
        log_warn "pre-commit is still not found after install attempt — hooks setup may fail"
        log_warn "Please ensure uv is in PATH and re-run this script"
    else
        log_info "pre-commit ready ($(pre-commit --version))"
    fi

    # The rest remains unchanged — git check, cache clean, autoupdate, install hooks
    if [[ ! -d "${PROJECT_ROOT}/.git" ]]; then
        log_error "Not inside a git repository (${PROJECT_ROOT})"
    fi
    cd "${PROJECT_ROOT}" || log_error "Failed to cd to project root"

    log_info "Cleaning pre-commit cache..."
    pre-commit clean --force >/dev/null 2>&1 || true
    pre-commit gc >/dev/null 2>&1 || true
    rm -rf ~/.cache/pre-commit/*pre-commit-hooks* 2>/dev/null || true

    if [[ -f .pre-commit-config.yaml ]]; then
        log_info "Updating hook versions..."
        retry_cmd "pre-commit autoupdate" || log_warn "autoupdate failed (non-critical)"
    else
        log_warn "No .pre-commit-config.yaml found — skipping autoupdate"
    fi

    log_info "Installing pre-commit hooks..."
    retry_cmd "pre-commit install --install-hooks -t pre-commit -t commit-msg" || {
        log_warn "Standard install failed — trying permissive mode"
        pre-commit install --allow-missing-config --install-hooks -t pre-commit -t commit-msg || \
            log_warn "pre-commit hook installation had issues — check logs"
    }

    log_info "${GREEN}pre-commit setup finished (hooks should be active if pre-commit is available)${NC}"
}

# ── Main ───────────────────────────────────────
main() {
    echo "Project setup starting in: ${PROJECT_ROOT}"

    ensure_snapd

    mkdir -p "${TOOLS_DIR}" || log_error "Failed to create ${TOOLS_DIR}"

    install_snap_tool "opentofu" "tofu"
    install_snap_tool "tflint"   "tflint"
    install_snap_tool "trivy"    "trivy"
    install_yamlfmt_binary

    install_and_setup_precommit

    echo
    log_info "Project setup complete!"
    echo "  • Tools status:"
    echo "      tofu, tflint, trivy → installed via snap (system-wide)"
    echo "      yamlfmt           → installed to ${TOOLS_DIR}"
    echo
    echo "  Recommended PATH addition (for yamlfmt):"
    echo "      export PATH=\"${TOOLS_DIR}:\$PATH\""
    echo "      (add to ~/.bashrc / ~/.zshrc)"
    echo
    echo "  Quick test commands:"
    echo "      tofu --version"
    echo "      tflint --version"
    echo "      trivy --version"
    echo "      yamlfmt --version"
    echo
    echo "  Your antonbabenko pre-commit hooks should now work (they look for tofu/tflint/trivy on PATH)."
}

main "$@"
