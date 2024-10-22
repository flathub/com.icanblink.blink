#!/usr/bin/bash
#
# Required commands: basename, jq, tar, tr, unzip

pkg_dir=${1:-'build/python-dependencies'}
sources_array_json='[]'
pip_packages=''

# Read metadata value by key and remove non-printable chars
read_meta_value () {
    pkg_meta_value=$(tr -dc '[[:print:]]' <<< ${1#"${2}"})
    echo "$pkg_meta_value"
}

# Add package source as JSON module format
add_package_source () {
    pkg_urls_json=$(curl -sS "https://pypi.org/pypi/$2/$3/json" | jq -jcM '.urls')
    pkg_file_json=$(echo "$pkg_urls_json" | jq -jcM '.[] | select(.filename=="'$1'") | {digests, url}')
    if [ -z "$pkg_file_json" ]; then
        echo "Cannot parse package JSON for $1"
        exit 1
    fi
    source_json=$(echo "$pkg_file_json" | jq '{type: "file", url: .url, sha256: .digests.sha256}')
    sources_array_json=$(echo "$sources_array_json" | jq ". + [$source_json]")
    pip_packages="$pip_packages \\\"$2\\\""
}

for pkg_path in $(ls $pkg_dir/*.whl); do
    # Search metadata entry
    pkg_filename=$(basename $pkg_path)
    pkg_metadata=""
    for pkg_meta_file in $(unzip -Z1 $pkg_path | grep METADATA); do
        pkg_prefix="${pkg_meta_file:0:-19}"
        if [[ $pkg_filename == "${pkg_prefix}"* ]]; then
            pkg_metadata=$pkg_meta_file
        fi
    done;
    if [ -z "$pkg_metadata" ]; then
        echo "Cannot parse package info for $pkg_filename"
        exit 1
    fi
    # Parse package metadata to get name and version
    pkg_name=''
    pkg_version=''
    while IFS= read -r pkg_meta_entry; do
        if [[ $pkg_meta_entry == 'Name: '* ]]; then
            pkg_name=$(read_meta_value "$pkg_meta_entry" 'Name: ')
        elif [[ $pkg_meta_entry == 'Version: '* ]]; then
            pkg_version=$(read_meta_value "$pkg_meta_entry" 'Version: ')
        fi
    done < <(unzip -p $pkg_path $pkg_metadata | head -n 20)
    add_package_source $pkg_filename $pkg_name $pkg_version
done;

for pkg_path in $(ls $pkg_dir/*.tar.gz); do
    # Search metadata entry
    pkg_filename=$(basename $pkg_path)
    pkg_metadata=""
    for pkg_meta_file in $(tar -tzf $pkg_path | grep PKG-INFO); do
        pkg_prefix="${pkg_meta_file:0:-9}"
        if [[ $pkg_filename == "${pkg_prefix}"* ]]; then
            pkg_metadata=$pkg_meta_file
        fi
    done;
    if [ -z "$pkg_metadata" ]; then
        echo "Cannot parse package info for $pkg_filename"
        exit 1
    fi
    # Parse package metadata to get name and version
    pkg_name=''
    pkg_version=''
    while IFS= read -r pkg_meta_entry; do
        if [[ $pkg_meta_entry == 'Name: '* ]]; then
            pkg_name=$(read_meta_value "$pkg_meta_entry" 'Name: ')
        elif [[ $pkg_meta_entry == 'Version: '* ]]; then
            pkg_version=$(read_meta_value "$pkg_meta_entry" 'Version: ')
        fi
    done < <(tar -xOf $pkg_path $pkg_metadata | head -n 20)
    add_package_source $pkg_filename $pkg_name $pkg_version
done;

# Print module JSON
build_command='pip3 install --verbose --exists-action=i --no-index --find-links=\"file://${PWD}\" --prefix=${FLATPAK_DEST}'$pip_packages
echo '{
"name": "python-dependencies",
"buildsystem": "simple",
"build-commands": [],
"sources": []
}' | jq ".sources = $sources_array_json | .\"build-commands\" = [ \"$build_command\" ]"