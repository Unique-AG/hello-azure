.PHONY: quality examples

.DEFAULT_GOAL := quality

quality:
	@echo "Running quality checks..."
	@./scripts/tf-docs.sh
	@./scripts/tf-fmt.sh
	@./scripts/tf-sec.sh
	@echo "Quality checks completed."
