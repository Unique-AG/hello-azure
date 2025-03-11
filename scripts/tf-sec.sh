#!/bin/bash
# SPDX-SnippetBegin
# SPDX-License-Identifier: Proprietary
# SPDX-SnippetCopyrightText: 2024 © Unique AG
# SPDX-SnippetEnd
echo "Running tf-sec"

# Create the output file with write permissions before mounting, so the docker run command can write to it
if [ "${GITHUB_ACTIONS}" = "true" ]; then
  touch tfsec-results.sarif
  chmod 666 tfsec-results.sarif
fi

# Base command
CMD="docker run --rm -v "$(pwd):/workdir" aquasec/tfsec /workdir --config-file /workdir/.github/configs/tfsec.yaml"

# Add SARIF output options only in GitHub Actions
if [ "${GITHUB_ACTIONS}" = "true" ]; then
  CMD="$CMD --format sarif --out /workdir/tfsec-results.sarif"
fi

# Execute the command
eval "$CMD"
