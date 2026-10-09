#!/usr/bin/env bash
set -euo pipefail

: "${BASE_SHA:?Pull request base SHA is required}"
: "${TAP_NAME:?Tap name is required}"
: "${RUNNER_TEMP:?Runner temporary directory is required}"

changed_casks=$(mktemp "$RUNNER_TEMP/changed-casks.XXXXXX")
cask_appdir=$(mktemp -d "$RUNNER_TEMP/cask-apps.XXXXXX")
trap 'rm -f "$changed_casks"; rm -rf "$cask_appdir"' EXIT

# The PR merge checkout includes both the base and the proposed changes.
# Disable rename detection so the destination of a renamed cask is tested.
git diff --name-only --no-renames --diff-filter=AM -z "$BASE_SHA" HEAD \
  -- ':(glob)Casks/**/*.rb' > "$changed_casks"

while IFS= read -r -d '' cask_file; do
  cask_name="${cask_file##*/}"
  cask_name="${cask_name%.rb}"
  qualified_cask="$TAP_NAME/$cask_name"
  # Still audit disabled and platform-specific definitions, but do not attempt
  # to install a cask that cannot run on this runner.
  install_status=$(brew ruby -r cask/cask_loader -e '
    cask = Cask::CaskLoader.load(ARGV.fetch(0))
    if cask.disabled?
      puts "disabled"
    elsif !cask.platform_supported?(Utils::Bottles.tag)
      puts "unsupported platform"
    else
      puts "installable"
    end
  ' -- "$qualified_cask")
  if [[ "$install_status" != installable ]]; then
    brew audit --cask --strict "$qualified_cask"
    echo "Skipping installation of $qualified_cask: $install_status"
    continue
  fi
  brew audit --cask --strict --online "$qualified_cask"
  brew fetch --cask "$qualified_cask"
  brew install --cask --appdir="$cask_appdir" "$qualified_cask"
  brew uninstall --cask "$qualified_cask"
done < "$changed_casks"
