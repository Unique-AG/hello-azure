#!/bin/bash
# SPDX-SnippetBegin
# SPDX-License-Identifier: Proprietary
# SPDX-SnippetCopyrightText: 2024 © Unique AG
# SPDX-SnippetEnd
echo "Running tf-sec"

# Base command
CMD="docker run --rm -v "$(pwd):/workdir" aquasec/tfsec /workdir --config-file /workdir/.github/configs/tfsec.yaml"

# Add SARIF output options only in GitHub Actions
if [ "${GITHUB_ACTIONS}" = "true" ]; then
  # Create the output file with write permissions before mounting, so the docker run command can write to it
  touch tfsec-results.sarif
  chmod 666 tfsec-results.sarif
  CMD="$CMD --format sarif --out /workdir/tfsec-results.sarif --soft-fail"
fi

# Execute the command
eval "$CMD"
