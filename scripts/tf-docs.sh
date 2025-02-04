#!/bin/bash
# SPDX-SnippetBegin
# SPDX-License-Identifier: Proprietary
# SPDX-SnippetCopyrightText: 2024 © Unique AG
# SPDX-SnippetEnd
## Reference: https://github.com/norwoodj/helm-docs
TF_DOCS_VERSION="0.19.0"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Repo root: $REPO_ROOT"

echo "Running tf-docs"

# Find all tfdocs.yaml files and process each one
find . -name "tfdocs.yaml" | while read -r config_file; do
    # Get the directory containing the tfdocs.yaml file
    dir=$(dirname "$config_file")
    
    echo "Processing $dir with config $config_file"
    
    docker run \
        --rm --volume "$(pwd):/workdir" \
        -u $(id -u) quay.io/terraform-docs/terraform-docs:$TF_DOCS_VERSION "/workdir/$dir" \
        --config "/workdir/$config_file"
done
