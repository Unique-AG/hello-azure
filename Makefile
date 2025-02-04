.PHONY: quality examples

.DEFAULT_GOAL := quality

quality:
	@echo "Running quality checks..."
	@./scripts/tf-docs.sh
	@./scripts/tf-fmt.sh
	@./scripts/tf-sec.sh
	@echo "Quality checks completed."

.PHONY: clean-runs

clean-runs:
	@echo "This will delete all workflow runs. Type 'yes' to continue."
	@read -p "" confirm && [ "$$confirm" = "yes" ] || exit 2
	@echo "Cleaning up workflow runs..."
	@gh run list -L 500 --json databaseId --jq '.[].databaseId' | xargs -I {} gh run delete {}
	@echo "Workflow runs cleaned up."