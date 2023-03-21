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

rm -Rf sources/pip-zzz
pip download -d sources/pip-zzz/ --find-links="file://${PWD}/sources/pip-zzz" "wheel" "pip" "cryptography<38.0.0" "pgpy" "PyQt-builder" "zope.interface" "gmpy2" "Cython" "dnspython" "greenlet" "gevent" "lxml" "sqlobject" "m2r" "twisted" "python-dateutil" "pyOpenSSL" "oauth2client" "service-identity" "google-api-python-client"

exit

rm -f .bash_history
sudo chown $(id -u):$(id -g) . -R

SOURCES="$(find sources/pip-zzz -type f | sort | awk '{print "{\"type\": \"file\", \"path\": \""$0"\"}"}' | jq -s -r -c '.')"
cat <<< $(jq --arg KEY "pip-zzz" --argjson SOURCES "$SOURCES" -r '(.modules[] | select(.name == $KEY).sources) = $SOURCES' com.icanblink.blink.json) > com.icanblink.blink.json

```

## mpv
```bash
yq -M -o json -P e /mnt/data/projects/personal/flatpak-github/io.mpv.Mpv/io.mpv.Mpv.yml \
  | jq '. |= . + {"name": "mpv-deps", "buildsystem": "simple", "build-commands": ["echo"]}' \
  | jq 'del(."app-id")' \
  | jq 'del(."runtime")' \
  | jq 'del(."runtime-version")' \
  | jq 'del(."sdk")' \
  | jq 'del(."command")' \
  | jq 'del(."rename-desktop-file")' \
  | jq 'del(."rename-icon")' \
  | jq 'del(."finish-args")' \
  | jq 'del(.modules[] | select (.name == "appdata" or .name == "yt-dlp"))' \
  | jq 'walk(if type == "object" then del(."x-checker-data") else . end)' \
  > io.mpv.Mpv.json

```

## x11vnc
```bash
curl 'https://github.com/LibVNC/x11vnc/commit/69eeb9f7baa1.patch' > patches/x11vnc-scan-limit-access-to-shared-memory.patch
curl 'https://github.com/LibVNC/x11vnc/commit/95a10ab64c2d.patch' > patches/x11vnc-xfc-null-ptr.patch
curl 'https://github.com/LibVNC/x11vnc/commit/a48b0b1cd887.patch' > patches/x11vnc-gcc10-fix.patch

```
