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
docker run -it --rm -v ${PWD}:/root:rw python:3.7 /bin/bash

cd

rm -Rf sources/pip-wheel
pip3.7 download -d sources/pip-wheel/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-wheel" "wheel"

rm -Rf sources/pip-pip
pip3.7 download -d sources/pip-pip/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-pip" "pip"

rm -Rf sources/pip-PyQt-builder
pip3.7 download -d sources/pip-PyQt-builder/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-PyQt-builder" "PyQt-builder"

rm -Rf sources/pip-otr
pip3.7 download -d sources/pip-otr/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-otr" "zope.interface"
pip3.7 download -d sources/pip-otr/ --find-links="file://${PWD}/sources/pip-otr" "gmpy2"
pip3.7 download -d sources/pip-otr/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-otr" "cryptography"

rm -Rf sources/pip-Cython
pip3.7 download -d sources/pip-Cython/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-Cython" "Cython"

rm -Rf sources/pip-dnspython
pip3.7 download -d sources/pip-dnspython/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-dnspython" "dnspython"

rm -Rf sources/pip-greenlet
pip3.7 download -d sources/pip-greenlet/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-greenlet" "greenlet"

rm -Rf sources/pip-gevent
pip3.7 download -d sources/pip-gevent/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-gevent" "gevent"

rm -Rf sources/pip-lxml
pip3.7 download -d sources/pip-lxml/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-lxml" "lxml"

rm -Rf sources/pip-twisted
pip3.7 download -d sources/pip-twisted/ --find-links="file://${PWD}/sources/pip-twisted" "m2r"
pip3.7 download -d sources/pip-twisted/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-twisted" "twisted"

rm -Rf sources/pip-python-dateutil
pip3.7 download -d sources/pip-python-dateutil/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-python-dateutil" "python-dateutil"

rm -Rf sources/pip-pyOpenSSL
pip3.7 download -d sources/pip-pyOpenSSL/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-pyOpenSSL" "pyOpenSSL"

rm -Rf sources/pip-oauth2client
pip3.7 download -d sources/pip-oauth2client/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-oauth2client" "oauth2client"

rm -Rf sources/pip-service-identity
pip3.7 download -d sources/pip-service-identity/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-service-identity" "service-identity"

rm -Rf sources/pip-google-api-python-client
pip3.7 download -d sources/pip-google-api-python-client/ --only-binary=:all: --find-links="file://${PWD}/sources/pip-google-api-python-client" "google-api-python-client"

exit

rm -f .bash_history
sudo chown $(id -u).$(id -g) . -R

find sources -type d -name 'pip-*' | cut -c 9- | while IFS='' read -r x; do
  SOURCES="$(find sources/${x} -type f | sort | awk '{print "{\"type\": \"file\", \"path\": \""$0"\"}"}' | jq -s -r -c '.')"
  cat <<< $(jq --arg KEY "${x}" --argjson SOURCES "$SOURCES" -r '(.modules[] | select(.name == $KEY).sources) = $SOURCES' com.icanblink.blink.json) > com.icanblink.blink.json
  cat <<< $(jq --arg KEY "${x}" --argjson SOURCES "$SOURCES" -r '(.modules[] | .modules[]? | select(.name == $KEY).sources) = $SOURCES' com.icanblink.blink.json) > com.icanblink.blink.json
done

```
