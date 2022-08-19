# Fastlane

- ### used to automate deployment of app to the App Store

## Fastlane Toolchain
- **produce:** creates new iOS apps in both App Store Connect and the Apple Developer Portal.
- **cert:** automatically creates and maintains iOS code-signing certificates.
- **sigh:** creates, renews, downloads and repairs provisioning profiles.
- **snapshot:** automates taking localized screenshots of your iOS app on every device.
- **frameit:** puts your screenshots into the right device frames.
- **gym:** builds and packages your iOS apps.
- **deliver:** uploads screenshots, metadata and your apps to the App Store.
- **pem:** automatically generates and renews your push notification profiles.
- **spaceship:** is a Ruby library able to access the Apple Developer Center and App Store Connect APIs.
- **pilot:** automates TestFlight deployments and manages beta testers.
- **boarding:** invites beta testers.
- **match:** syncs certificates and provisioning profiles across your team, using Git.
- **scan:** runs tests on your apps.

## Fastlane Commands
- ***fastlane init***
	- it will initiate the fastlane, creating some files llike `Gemfile`, `Fastfile`, `Appfile`. 
	- **Gemfile:** includes the fastlane gem as a project dependency
	- **Appfile:**
		- The Appfile stores useful information that are used across all fastlane tools like your Apple ID or the application Bundle Identifier, to deploy your lanes faster and tailored on your project needs.
	- **Fastfile:** manages the lanes you’ll create to invoke fastlane actions. Fastfile example:
```
# Fastfile example
default_platform(:ios)

platform :ios do
  desc "Create app on Apple Developer and App Store Connect sites"
  lane :create_app do
    produce #add the app to both the Developer Portal and App Store Connect.
  end
end
```
- ***fastlane create_app***
	- using previously generated file it will create new app on both App Store Connect and the Apple Developer Portal
- ***bundle exec fastlane deliver***
	- this will generate `metadata directory`, `Deliverfile` and `screenshots directory`.
- ***fastlane snapshot init***
	- a `Snapfile` will genereted by this command
	- in this `Snapfile` we can specify:
		- The devices from which you want fastlane to capture your screenshots.
		- The localized languages you want to capture.
		- The name of the Xcode scheme you’ll soon create to run screenshot automation.
		- The screenshot output directory.
		- That fastlane should clear any screenshots in the output directory before capturing new ones.
- ***fastlane gym init***
	- a `Gymfile` will be created which can be used for Building and uploading the app.

```ruby
# Gymfile example
scheme("WatherToday") # projects scheme name
output_directory("./fastlane/builds")
include_bitcode(false)
include_symbols(false)
export_xcargs("-allowProvisioningUpdates") 

```

```
# Fastfile example for enabling both Screenshot and build with Gymfile
default_platform(:ios)

platform :ios do
  desc "Create app on Apple Developer and App Store Connect sites"
  lane :create_app do
    produce
  end
  desc "Take screenshots"
  lane :screenshot do
    snapshot
  end
  desc "Create ipa"
  lane :build do
    enable_automatic_code_signing
    increment_build_number
    gym
  end
end

```














