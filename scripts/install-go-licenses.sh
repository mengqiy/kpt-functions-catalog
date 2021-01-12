#! /bin/bash

set -euo pipefail

GO_LICENSES_TMP_DIR=$(mktemp -d)
cd "$GO_LICENSES_TMP_DIR"
go mod init tmp
go get github.com/google/go-licenses
export PATH=$PATH:$GOPATH/bin
rm -rf "$GO_LICENSES_TMP_DIR"