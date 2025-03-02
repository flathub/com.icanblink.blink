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
flatpak --user --share=network --filesystem=host --command=pip3 run 'org.kde.Sdk//6.8' \
install --ignore-installed --report - --dry-run --quiet --requirement requirements.txt | \
./python-dependencies.sh > modules/python-dependencies.json 

```

### x11vnc
```bash
curl 'https://github.com/LibVNC/x11vnc/commit/69eeb9f7baa1.patch' > patches/x11vnc-scan-limit-access-to-shared-memory.patch
curl 'https://github.com/LibVNC/x11vnc/commit/95a10ab64c2d.patch' > patches/x11vnc-xfc-null-ptr.patch
curl 'https://github.com/LibVNC/x11vnc/commit/a48b0b1cd887.patch' > patches/x11vnc-gcc10-fix.patch

```
