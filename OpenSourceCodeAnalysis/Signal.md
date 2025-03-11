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
- While running above command, you might face error like this:
`'urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED]` . To solve it you need to follow [this answer](https://stackoverflow.com/a/70495761/4245112).


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
- Details of folder structure is [HERE](signal_res/signal_folder_structure.txt)


### App Architecture
<img src="signal_res/AppArc.png" alt="AppArc.png" />

- In this Diagram `Request` means request for Data, Service or UI and `Response` may contain Data, Service or UI.

#### Presentation layer
- Presentation layer contains Views and business logics. Views contains ViewControllers, UIViews, SwiftUI views. This layer also contains Presenters, ViewModels, Coordinators.
- This module mostly follows Model-View-Presenter (MVP) architecture, for example: `RegistrationVerificationViewController` acted as a `View` and there are `RegistrationVerificationPresenter` played as `Presenter` while `RegistrationVerificationState` and  `RegistrationVerificationValidationError` acted as `Model`.
- Delegation(Protocol-Delegate) is used to maintain communication among the components. For example:
	- `RegistrationVerificationViewController` contains presenter as a weak variable.

`private weak var presenter: RegistrationVerificationPresenter?`

	
- Functionalities of `RegistrationVerificationPresenter` is implemented inside `RegistrationNavigationController` which also initiates the `RegistrationVerificationViewController` with state and presenter.
- `RegistrationNavigationController` also contains coordintor through protocol `RegistrationCoordinator` and maintain navigation flow for registration. Implementation of `RegistrationCoordinator` is done in `RegistrationCoordinatorImpl`.

- A demo class diagram with minimal code:







```mermaid
%%{init: {'theme': 'base', 'flowchart': { 'width': 1200, 'height': 2000 } } }%%
classDiagram
    class RegistrationCoordinatorImpl {
        +init(mode: RegistrationCoordinatorLoaderImpl.Mode, loader: RegistrationCoordinatorLoaderDelegate, dependencies: RegistrationCoordinatorDependencies)
        +switchToSecondaryDeviceLinking() Bool
    }

    class RegistrationCoordinator {
        <<protocol>>
        +switchToSecondaryDeviceLinking() Bool
    }

    class RegistrationNavigationController {
        -appReadiness: AppReadinessSetter
        -coordinator: RegistrationCoordinator
        +withCoordinator(_: RegistrationCoordinator, appReadiness: AppReadinessSetter) RegistrationNavigationController
        -init(coordinator: RegistrationCoordinator, appReadiness: AppReadinessSetter)
        +viewDidLoad()
        -controller(for: RegistrationStep) AnyController?
    }

    class RegistrationVerificationViewController {
        -presenter: RegistrationVerificationPresenter?
        +init(state: RegistrationVerificationState, presenter: RegistrationVerificationPresenter)
    }

    class RegistrationVerificationPresenter {
        <<protocol>>
        +returnToPhoneNumberEntry()
    }

    RegistrationCoordinatorImpl --|> RegistrationCoordinator : implements
    RegistrationNavigationController --> RegistrationCoordinator : depends on
    RegistrationNavigationController ..|> RegistrationVerificationPresenter : implements
    RegistrationVerificationViewController --> RegistrationVerificationPresenter : depends on
```




### Singleton Instance: SignalApp
### Dependency Injection
- No 3rd party library is used to maintain dependency, it is fully managed manually. For example: in `AppDelegate` they initiate `DataBase` like this:

```
let databaseStorage: SDSDatabaseStorage
do {
    databaseStorage = try SDSDatabaseStorage(
        appReadiness: appReadiness,
        databaseFileUrl: SDSDatabaseStorage.grdbDatabaseFileUrl,
        keychainStorage: keychainStorage
    )
} catch KeychainError.notAllowed where application.applicationState == .background {
    notifyThatPhoneMustBeUnlocked()
} catch {
    // It's so corrupt that we can't even try to repair it.
    didAppLaunchFail = true
    Logger.error("Couldn't launch with broken database: \(error.grdbErrorForLogging)")
    let viewController = terminalErrorViewController()
    _ = initializeWindow(mainAppContext: mainAppContext, rootViewController: viewController)
    presentDatabaseUnrecoverablyCorruptedError(from: viewController, action: .submitDebugLogsAndCrash)
    return true
}
```




































