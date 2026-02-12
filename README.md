# Blink Flatpak
This is the Qt version of Blink, a fully featured, easy to use SIP client.

Homepage: http://icanblink.com

## Users

### Features

The complete list of features and implemented standards are available at:

http://icanblink.com/features/

### Installation

Add the Flathub remote.

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

Install the Thonny Flatpak.

    flatpak install flathub com.icanblink.blink

### Support

For help on using Blink Qt go to http://icanblink.com/help/

### Changelog

The changelog is available at http://icanblink.com/changelog/

### Credits

 * AG Projects: http://ag-projects.com
 * NLnet foundation: http://nlnet.nl
 * IETF Community: http://www.ietf.org
 * SIP SIMPLE client SDK: http://sipsimpleclient.org

------

## Maintainers

### Build

1. Get the source code:

       git clone https://github.com/flathub/com.icanblink.blink.git
       cd com.icanblink.blink

2. Add the Flathub repository:

       flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

3. Install Flatpak Builder:

       sudo (apt|dnf|zypper|pacman|…) install flatpak-builder

4. Build the Flatpak:

        flatpak-builder --system --ccache --install --install-deps-from=flathub --force-clean --repo=repo build com.icanblink.blink.yaml

5. Run the Flatpak:

        flatpak run com.icanblink.blink

### Update

The Python dependencies for the Flatpak are generated with the help of the
[Flatpak Pip Generator](https://github.com/flatpak/flatpak-builder-tools/tree/master/pip),
which produces `json` files for Python packages to be included in the Flatpak
manifest’s `modules` section.

1. First, install the Python dependencies for the PIP and Cargo generators:

       python3 -m pip install aiohttp requirements-parser toml yq

2. Clone the `flatpak-builder-tools` repository:

       git clone https://github.com/flatpak/flatpak-builder-tools.git

3. Open the `requirements.txt` file and follow the links there to check if all
   listed requirement items are up-to-date with what is listed at the links
   in the respective sections.

   If new build dependencies are added, add clean-up rules to the `cleanup`
   section of `com.icanblink.blink.yaml`.

4. Open https://github.com/AGProjects/python3-sipsimple/blob/master/get_dependencies.sh
   and check that the PJSIP version and ZRTPCPP commit inside of the
   `name: python3-sipsimple` block in `com.icanblink.blink.yaml` match what is
   specified in the `get_dependencies.sh` file.

5. Run the Flatpak Pip Generator script for the necessary packages
   (replace “\<SDK-Version>” with the SDK version listed inside `com.icanblink.blink.yaml`):

       ./flatpak-builder-tools/pip/flatpak-pip-generator.py --runtime="org.kde.Sdk//<SDK-Version>" --requirements-file requirements.txt --output pypi-dependencies

6. Run the fixup script to add Rust dependencies to all Python packages:

       ./pypi-dependencies-fixup-rust.py ./flatpak-builder-tools/cargo/flatpak-cargo-generator.py

   This patches the `pypi-dependencies.json` file to ensure all Cargo
   dependencies are downloaded by `flatpak-builder` to make an offline build
   possible.

7. Open https://icanblink.com/changelog-linux/ and add the new changelog
   entries to `com.icanblink.blink.metainfo.xml` following the existing style.

8. Perform test build and *run it* to test as many features as possible.