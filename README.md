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

## pip
```bash
docker run -it --rm -v ${PWD}:/root:rw python:3.9 /bin/bash

bind 'set enable-bracketed-paste off'

cd

rm -Rf sources/pip
pip download -d sources/pip/ --find-links="file://${PWD}/sources/pip" "cryptography<38.0.0" "Cython" "dnspython" "enum34" "gevent" "gmpy2" "google-api-python-client" "greenlet" "lxml" "m2r" "oauth2client" "pgpy" "pip" "pyOpenSSL" "PyQt-builder" "python-dateutil" "service_identity" "sqlobject" "twisted" "wheel" "zope.interface"

exit

rm -f .bash_history
sudo chown $(id -u):$(id -g) . -R

SOURCES="$(find sources/pip -type f | sort | awk '{print "{\"type\": \"file\", \"path\": \""$0"\"}"}' | jq -s -r -c '.')"
cat <<< $(jq --arg KEY "pip" --argjson SOURCES "$SOURCES" -r '(.modules[] | select(.name == $KEY).sources) = $SOURCES' com.icanblink.blink.json) > com.icanblink.blink.json

```

## mpv
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

## x11vnc
```bash
curl 'https://github.com/LibVNC/x11vnc/commit/69eeb9f7baa1.patch' > patches/x11vnc-scan-limit-access-to-shared-memory.patch
curl 'https://github.com/LibVNC/x11vnc/commit/95a10ab64c2d.patch' > patches/x11vnc-xfc-null-ptr.patch
curl 'https://github.com/LibVNC/x11vnc/commit/a48b0b1cd887.patch' > patches/x11vnc-gcc10-fix.patch

```
