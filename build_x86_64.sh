#!/usr/bin/env bash

set -e

xcodebuild -configuration Release -derivedDataPath DerivedData/TrollInstallerX -destination 'platform=iOS Simulator' -scheme TrollInstallerX CODE_SIGNING_ALLOWED="NO" CODE_SIGNING_REQUIRED="NO" CODE_SIGN_IDENTITY="" ARCHS=x86_64 VALID_ARCHS=x86_64
cp Resources/ents.plist DerivedData/TrollInstallerX/Build/Products/Release-iphoneos/
pushd DerivedData/TrollInstallerX/Build/Products/Release-iphoneos
rm -rf Payload TrollInstallerX.ipa
mkdir Payload
cp -r TrollInstallerX.app Payload
ldid -Sents.plist Payload/TrollInstallerX.app
zip -qry TrollInstallerX.ipa Payload
popd
cp DerivedData/TrollInstallerX/Build/Products/Release-iphoneos/TrollInstallerX.ipa .
rm -rf Payload
open -R TrollInstallerX.ipa
