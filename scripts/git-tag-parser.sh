#!/bin/bash
#
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VERNUM='0|[1-9][0-9]*'

# An example is "set-namespace/v1.2.3"
GIT_TAG_SEMVER_REGEX="\
^([a-zA-Z]*([-_.][a-zA-Z]+)*)\/\
[vV]?($VERNUM)\\.($VERNUM)\\.($VERNUM)$"

# get_versions return versions: vX.Y.Z, vX.Y and vX if the input matches
# GIT_TAG_SEMVER_REGEX. Otherwise, it returns the input.
function get_versions {
  local version=$1
  if [[ "${version}" =~ $GIT_TAG_SEMVER_REGEX ]]; then
    local major=${BASH_REMATCH[3]}
    local minor=${BASH_REMATCH[4]}
    local patch=${BASH_REMATCH[5]}

    echo v"${major}"."${minor}"."${patch}"
    echo v"${major}"."${minor}"
    echo v"${major}"
  else
    echo "${version}"
  fi
}

# get_fn_name return the function name if the input matches GIT_TAG_SEMVER_REGEX.
# Otherwise, it returns nothing.
function get_fn_name {
  local version=$1
  if [[ "${version}" =~ $GIT_TAG_SEMVER_REGEX ]]; then
    echo "${BASH_REMATCH[1]}"
  fi
}
