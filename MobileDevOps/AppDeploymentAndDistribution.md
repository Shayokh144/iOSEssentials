# iOS
## App Deployment & Distribution 
- Deployment & Distribution using [firebase](https://code.tutsplus.com/tutorials/getting-started-with-continuous-delivery-and-fastlane-for-ios--cms-30706)
## [Types of App distribution](https://www.kodeco.com/books/ios-app-distribution-best-practices/v1.0/chapters/5-internal-distribution)


### Personal Team distribution
When you register as an Apple developer, you automatically get access to Personal Team, which is a bare-bones version of the full Apple Development Program.

Personal Team allows you to distribute apps to a few devices using Xcode without having to pay for the full enrollment. Personal Team distribution is meant for learning and getting started with the SDKs. Builds you distribute this way expire after a couple of days.

### Ad hoc distribution
When you enroll and pay for the full Apple Developer Program, either as an individual or as an organization, you gain the ability to achieve limited distribution to a small group by using ad hoc distribution.

Ad hoc distribution is not a long-term or scalable distribution solution. You can only distribute apps to up to 100 devices per product family per year and builds expire yearly. Developers often use ad hoc distribution to deploy alpha, internal-facing builds, usually as part of a build pipeline.
Requirements:
- An Apple ID enrolled in the Apple Developer Program. You also need to be logged into Xcode with the same Apple ID.
- An App ID registered in Apple’s developer portal for the raywenderlich.com app. You should already have this set up from Chapter 3, “Submitting Your First App for Review”. If not, go back to that chapter to learn how to create one.
- A distribution certificate registered in the developer portal and saved to Keychain Access on your Mac. If you don’t already have one, Chapter 4, “Code Signing & Provisioning”, can help.
- An iOS device. This can be any iPhone or iPad running iOS 13.4 or newer, to match the sample app’s deployment target.

### TestFlight
TestFlight is Apple’s officially supported method for distributing beta — that is, external-facing — builds for testing and gathering feedback. Since Apple makes TestFlight, it’s deeply integrated with the App Store and App Store Connect.

With TestFlight, you can have up to 100 internal testers and up to 10,000 external testers, making it a good option if you run into the 100-device limit with ad hoc distribution. Keep in mind, however, that TestFlight builds are only active for 90 days so it’s not a long-term solution. Chapter 6, “TestFlight” covers this method in detail.

### In-house distribution
In-house distribution allows large organizations to develop and deploy internal-use apps for employees. To use it, you need to apply to the Apple Developer Enterprise Program, which is separate from the regular program, and pay an additional 299 U.S. dollars per year.

In-house distribution also allows large-scale alpha build distribution without having to worry about the 100-device limit. Most of this chapter also applies to in-house distribution of enterprise builds.

### Custom App Distribution
For a long time, in-house distribution was the only supported way to achieve large-scale internal deployments. Nowadays, Apple prefers you to use Custom App Distribution. In-house distribution still exists to support edge cases where Custom App Distribution doesn’t apply.

Unlike in-house distribution, Custom App Distribution leverages the App Store’s tools and infrastructure, like TestFlight and App Store Connect. If you’re distributing an internal app for a large organization, Custom App Distribution should be at the top of your list.

## Understanding Provision Profile and Certificate 
- [Provision Profile and Certificate](https://www.youtube.com/watch?v=Ys2p5bFhgjI&t=156s)
- [iOS App signing](https://www.youtube.com/watch?v=0lJvQ-442OY)
- [iOS App Signing summary](https://www.youtube.com/watch?v=0lJvQ-442OY&t=650s)

### Code signing
- Code Signing is the process of digitally sign any form of code to ensue who writes the code and tho code has not been changed or corrupted when it was signed.

### Certificate signing request (CSR)
- A CSR is basically a message sent from ans applicant to a certificate authority in order to apply for a certificate.
- A CSR is a block of encoded text that is given to a certificate authority when applying for a certificate.
- Keychain Application will create a `private key` and a `certSigningRequest` file which will be then uploaded to Apple
- Apple will proof the request and issue a certificate
- The certificate will pushed to keychain and paired with private key to form the `Code Signing Identity`
- Finally at the time of app installation the private key used to sign the app matches the public key in the certificate, if it fails app won't install in device.


### Provision Profile
- Provision profile act like a link between physical device and apple developer account. Without provision profile app cannot be installed on physical device. `It decides which devices can run the app and what services (like push notifications) it can be accessed.` 
- Provision profile contains 3 things: `Development Certificates`, `UDID of devices` that can run the app, `App Id`(it is a two part string used to identify one or more apps from a single development teams)


## [Create distribution profile](https://blog.instabug.com/how-to-submit-app-to-app-store/#codesigning) 

## App Release

- [Bump build version](https://www.raywenderlich.com/books/ios-app-distribution-best-practices/v1.0/chapters/3-submitting-your-first-app-for-review#toc-chapter-009-anchor-005)
    - Semantic versioning, is a three-component number in the format of A.B.C, where:

        “A” represents a major version, e.g., when you add a new feature. “B” represents a minor version, e.g., when you enhance an existing feature.“C” represents a patch, e.g., a bug fix. Example: 1.0.1

- [Submitting an app to Appstore manually](https://blog.instabug.com/how-to-submit-app-to-app-store/)


# Android
- [Continious Delivery with Fastlane and Github action](https://www.kodeco.com/19407406-continuous-delivery-for-android-using-github-actions)
- [Deploy app to play store](https://support.google.com/googleplay/android-developer/answer/9859152?hl=en&visit_id=638039580049661648-4038611061&rd=1)
