#!/usr/bin/bash
#
# Converts a pip3 install report into a Flatpak dependency module.
#
# Requires: jq

# Test for stdin: exit if no data
[ -t 0 ] && exit 0

# Parse stdin json metadata from pip3, take a dry-run install report like:
#	pip3 install --ignore-installed --report - --dry-run --quiet [...]
install_json=$(jq -c '[ .install[] | {name: .metadata.name, url: .download_info.url, sha256: .download_info.archive_info.hashes.sha256} ] | sort_by(.name)')

# Generate packages list: join quoted "name"
package_list=$(echo $install_json | jq -r '[ .[].name | tojson ] | join(" ")')

# Generate sources array: transform metadata array into sources {type, url, sha256}
sources_json=$(echo $install_json | jq -c '[ .[] | {type: "file", url: .url, sha256: .sha256} ]')

# Generate build command from package list
build_command=$(echo -n "pip3 install --verbose --exists-action=i --no-index --find-links=\"file://\${PWD}\" --prefix=\${FLATPAK_DEST} $package_list" | jq -Rcs '.')

# Print json module
echo '{
"name": "python-dependencies",
"buildsystem": "simple",
"build-commands": [],
"sources": []
}' | jq ".sources=$sources_json | .\"build-commands\"=[${build_command}]"