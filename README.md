## Blink
This is the Qt version of Blink, a fully featured, easy to use SIP client
for Linux and Microsoft Windows.

Homepage: http://icanblink.com

## Features

The complete list of features and implemented standards are available at:

http://icanblink.com/features/

## Installation

Installation instructions can be found at:

http://icanblink.com/download/

## Support

For help on using Blink Qt go to http://icanblink.com/help/

## Changelog

The changelog is available at http://icanblink.com/changelog/

## Credits

 * AG Projects: http://ag-projects.com
 * NLnet foundation: http://nlnet.nl
 * IETF Community: http://www.ietf.org
 * SIP SIMPLE client SDK: http://sipsimpleclient.org

------

## Flatpak development

### Python dependencies

Dependencies are declared in `requirements.txt` file. Use the target runtime and
the `python-dependencies.sh` script to build/update the dependencies module:

```bash
flatpak --user --share=network --filesystem=host --command=pip3 run 'org.kde.Sdk//5.15-23.08' \
install --ignore-installed --report - --dry-run --quiet --requirement requirements.txt | \
./python-dependencies.sh > modules/python-dependencies.json 

```

<!--
### mpv
```bash
curl -s 'https://raw.githubusercontent.com/flathub/io.mpv.Mpv/master/io.mpv.Mpv.yml' | yq -M -o json -P e \
  | jq '. |= . + {"name": "mpv-deps", "buildsystem": "simple", "build-commands": ["echo"]}' \
  | jq 'del(."app-id")' \
  | jq 'del(."runtime")' \
  | jq 'del(."runtime-version")' \
  | jq 'del(."sdk")' \
  | jq 'del(."command")' \
  | jq 'del(."rename-desktop-file")' \
  | jq 'del(."rename-icon")' \
  | jq 'del(."finish-args")' \
  | jq 'del(.modules[] | select(.name == "appdata" or .name == "yt-dlp"))' \
  | jq 'del(.modules[] | select(.name == "mpv") | .sources[] | select(.type == "file" or .type == "shell"))' \
  | jq 'walk(if type == "object" then del(."x-checker-data") else . end)' \
  > modules/io.mpv.Mpv.json

```
-->

### x11vnc
```bash
curl 'https://github.com/LibVNC/x11vnc/commit/69eeb9f7baa1.patch' > patches/x11vnc-scan-limit-access-to-shared-memory.patch
curl 'https://github.com/LibVNC/x11vnc/commit/95a10ab64c2d.patch' > patches/x11vnc-xfc-null-ptr.patch
curl 'https://github.com/LibVNC/x11vnc/commit/a48b0b1cd887.patch' > patches/x11vnc-gcc10-fix.patch

```
