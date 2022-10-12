# XCODE BUILD


## Build iOS Project From Terminal


	xcrun xcodebuild -workspace YOUR_WORKSPACE.xcworkspace -scheme YOUR_SCHEME -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 12 Pro,OS=15.2' -derivedDataPath 'LOCATION_TO_SAVE_DERIVED_DATA' test

## Archive iOS Project From Terminal:


	xcodebuild -workspace YOUR_WORKSPACE.xcworkspace -scheme WeatherToday archive -archivePath PATH_TO_SAVE_ARCHIVE/NAME_OF_YOUR_ARCHIVE.xcarchive

## Export IPA From Terminal:


	xcodebuild -exportArchive -archivePath PATH_TO_SAVED_ARCHIVE/NAME_OF_YOUR_ARCHIVE.xcarchive -exportPath  PATH_TO_SAVE_YOUR_IPA/WeatherToday.ipa -exportOptionsPlist  PATH_TO_EXPORT_OPTION_PLIST/ExportOptions.plist


`We need to create this **ExportOptions.plist** file before running the above command. Easiest way to do this is to create ipa from Xcode once the in the ipa's folder you will find a ExportOptions.plist that you can use for future.`


### Resources

- [Apple doc](https://developer.apple.com/library/archive/technotes/tn2339/_index.html)
- [xcodebuild man page](http://www.manpagez.com/man/1/xcodebuild/)
- [xcrun man page](http://www.manpagez.com/man/1/xcrun/)