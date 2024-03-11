#!/bin/sh

set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 PACKAGE_DIRECTORY COMMIT_HASH"
  exit 1
fi

PACKAGE_DIRECTORY="$1"
COMMIT_HASH="$2"

if ! [ -d "$PACKAGE_DIRECTORY" ]; then
  echo "'$PACKAGE_DIRECTORY' is not a directory."
  exit 1
fi

PACKAGE_FILE="$PACKAGE_DIRECTORY/Package.swift"

if ! [ -f "$PACKAGE_FILE" ]; then
  echo "'$PACKAGE_FILE' does not exist."
  exit 1
fi

NEW_PACKAGE_LINE="\\.package(url: \"https:\\/\\/github\\.com\\/opennetltd\\/Composed\\.git\", revision: \"$COMMIT_HASH\"),"

sed -i '' "s/\\.package(url: \"https:\\/\\/github\\.com\\/opennetltd\\/Composed\\.git\".*/$NEW_PACKAGE_LINE/g" "$PACKAGE_FILE"

xcodebuild -resolvePackageDependencies
