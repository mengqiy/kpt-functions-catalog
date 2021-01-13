#! /bin/bash

set -euo pipefail

scripts_dir="$(dirname "$0")"
# git-tag-parser.sh has been shell-checked separately.
# shellcheck source=/dev/null
source ${scripts_dir}/git-tag-parser.sh

DEV_TAG=dev
GIT_TAG=${GIT_TAG:-"${TAG}"}
versions=$(get_versions "${GIT_TAG}")
fn_name=$(get_fn_name "${GIT_TAG}")
fn_name=${fn_name:-"${CURRENT_FUNCTION}"}
GCR_REGISTRY=${GCR_REGISTRY:-gcr.io/kpt-functions}

cd "${scripts_dir}"/../functions/go
docker build -t "${GCR_REGISTRY}/${fn_name}:${DEV_TAG}" -f "${fn_name}"/Dockerfile "${fn_name}"

for version in ${versions}; do
  echo tagging "${GCR_REGISTRY}/${fn_name}:${version}"
  docker tag "${GCR_REGISTRY}/${fn_name}:${DEV_TAG}" "${GCR_REGISTRY}/${fn_name}:${version}"
done
