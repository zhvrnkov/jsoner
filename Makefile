root=~/.jsoner
package_description=PackageDescription
release_binary=.build/release/JSONer
executable_path=/usr/local/bin/jsoner

install: install_package_description install_binary

install_binary: build_binary
	cp $(release_binary) $(executable_path)

build_binary:
	swift build -c release --disable-sandbox

install_package_description:
	mkdir -p $(root)
	cp -r $(package_description) $(root)/

xcode:
	swift package generate-xcodeproj

.PHONY: install xcode
