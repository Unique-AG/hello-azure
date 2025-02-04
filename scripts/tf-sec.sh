#!/bin/bash
# SPDX-SnippetBegin
# SPDX-License-Identifier: Proprietary
# SPDX-SnippetCopyrightText: 2024 © Unique AG
# SPDX-SnippetEnd
echo "Running tf-sec"
docker run --rm -v "$(pwd):/workdir" aquasec/tfsec /workdir --config-file /workdir/.github/configs/tfsec.yaml
