# iOS
## Fastlane Basics

- ### Fastlane is a tool that automates the build, test and deployment of mobile apps. It is an open source platform aimed at simplifying Android and iOS deployment. It lets you automate every aspect of your development and release workflow.
- In other words, fastlane handles all the tedious tasks of automating code signing, App Store upload, etc. Most of the native iOS projects are currently using fastlane.

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

## Fastlane Cert and Sigh
- [Resource](https://www.youtube.com/watch?v=90hJDqbUyqM)

## Fastlane match
- [Resource](https://youtu.be/Edr88s5YlH4)

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
- Update contents in app file to add apple id and bundle id of app
```
# App File example
apple_dev_portal_id("[[APPLE_DEVELOPER_ACCOUNT_USERNAME]]")
itunes_connect_id("[[APP_STORE_CONNECT_ACCOUNT_USERNAME]]")
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
    enable_automatic_code_signing # Enables automatic provisioning in Xcode.
    increment_build_number
    gym
  end
end

```

- ***bundle exec fastlane build***
	- this will execute the fast file to build and create `ipa`. Before running this command make sure to update signinginformation in xcode  `Signing & Capabilities` tab for both `Debug` and `Release`.
	- `ipa` file will be in the `/fastlane/builds/` path
- ***bundle exec fastlane upload***
	- will upload files to app store with the help of `Deliverfile` and `Fastfile`.

```ruby
# deliver file example

price_tier(0)
submission_information({
    export_compliance_encryption_updated: false,
    export_compliance_uses_encryption: false,
    content_rights_contains_third_party_content: false,
    add_id_info_uses_idfa: false
})
app_rating_config_path("./fastlane/metadata/app_store_rating_config.json")
ipa("./fastlane/builds/mZone Poker.ipa")
submit_for_review(false) # true will automatically submit the app for review, as it is a test project I won't submit it
automatic_release(false) # false to release the app manually after it’s accepted by app review

```

need to add below codes in `Fastfile` also

``` ruby
  desc "Upload to App Store"
  lane :upload do
    deliver
  end
```



## Other commands

- To find all available input output of fastlane action run:

		fastlane action COMMAND_NAME
example: `fastlane action gym`


# Android

- For android follow [this](https://docs.fastlane.tools/getting-started/android/setup/) 
- Everything is almost similar to iOS just we need `Google credentials` rather than Apple's
- Run [tests](https://docs.fastlane.tools/getting-started/android/running-tests/)
- Capture Screenshots [Automatically](https://docs.fastlane.tools/getting-started/android/screenshots/)












