# Signal-iOS


## Introduction
[Signal](https://github.com/signalapp/Signal-iOS/tree/main) is a free, open source, messaging app for simple private communication with friends.


## Requirements

- Xcode 15 or highier
- iOS 15 or highier

## Installation

- Signal makes use of sub-modules, we must use git clone:

`git clone --recurse-submodules https://github.com/signalapp/Signal-iOS`

- Mode to the `Signal-iOS` folder and run:

`make dependencies`

- Open the `Signal.xcworkspace` in Xcode.
- You can run `Signal` or `Signal-Staging` in the simulator.

## Application Architecture

### Folder Structure
- From the folder structure, we can see that the Signal iOS app is organized based on features and functionalities. Each folder corresponds either to a user-facing feature, such as the registration process, or to internal functionalities, like managing app launch operations. A detailed folder structure is provided below.

- Inside each feature folder, we find feature-related logic classes alongside a `UserInterface` subfolder, which contains all the views (Views) and controllers (ViewControllers).

- For example, let’s examine the Registration folder:
	- The Registration folder contains code for user onboarding, phone number verification, and account creation in Signal. It includes logic for validating phone numbers, managing registration states, and handling UI screens for the registration process.
	- Files like `RegistrationCoordinator.swift, RegistrationCoordinatorImpl.swift, RegistrationCoordinatorImpl+Service.swift, and RegistrationCoordinatorLoader.swift` contain navigation logic and manage the overall registration flow.
	- A file like PhoneNumberValidator.swift contains validation logic for phone numbers.
	- The UserInterface subfolder contains all view-related files.
	- There are specific view controller classes, such as `RegistrationRestoreFromBackupViewController.swift` `RegistrationChangePhoneNumberViewController.swift`, `RegistrationVerificationViewController.swift`, which handle UI interactions for functionalities like changing a phone number during registration, restoring an account from a backup or processing registration verification code.
	- ViewControllers most of the time contains a `State struct` that holds the state of the view and a `protocol Presenter`, that contains presentation logic. For example in the file `RegistrationVerificationViewController.swift` you will find `RegistrationVerificationPresenter` and `RegistrationVerificationState`.

```
├── AppLaunch
│   ├── AppDelegate.swift
│   ├── AppEnvironment.swift
│   ├── LaunchJobs.swift
│   ├── LoadingViewController.swift
│   ├── MainAppContext.swift
│   └── SignalApp.swift
├── Registration
│   ├── PhoneNumberValidator.swift
│   ├── RegistrationCoodinatorShims.swift
│   ├── RegistrationCoordinator.swift
│   ├── RegistrationCoordinatorDependencies.swift
│   ├── RegistrationCoordinatorImpl+Service.swift
│   ├── RegistrationCoordinatorImpl.swift
│   ├── RegistrationCoordinatorLoader.swift
│   ├── RegistrationMode.swift
│   ├── RegistrationStep.swift
│   ├── RegistrationUtils.swift
│   └── UserInterface
│       ├── RegistrationCaptchaViewController.swift
│       ├── RegistrationChangeNumberSplashViewController.swift
│       ├── RegistrationChangePhoneNumberConfirmationViewController.swift
│       ├── RegistrationChangePhoneNumberViewController.swift
│       ├── RegistrationConfirmModeSwitchViewController.swift
│       ├── RegistrationEnterBackupKeyViewController.swift
│       ├── RegistrationLoadingViewController.swift
│       ├── RegistrationNavigationController.swift
│       ├── RegistrationPermissionsView.swift
```
- Details folder structure is [HERE](signal_res/signal_folder_structure.txt)


### App Architecture
<img src="signal_res/AppArc.png" alt="AppArc.png" />
