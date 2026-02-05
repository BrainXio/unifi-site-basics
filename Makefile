.PHONY: env-setup pre-commit site-docs readme

dev-setup: ## Setup the local dev env
	./scripts/env-setup.sh

pre-commit: ## Run pre-commit on all files
	pre-commit run --all-files

site-docs: ## Refresh site docs (header, footer if .tf files exist)
	./scripts/site-docs.sh

readme: ## Refresh README.md (header, footer + docs if .tf files exist)
	./scripts/site-docs.sh --make

.PHONY: help
help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
