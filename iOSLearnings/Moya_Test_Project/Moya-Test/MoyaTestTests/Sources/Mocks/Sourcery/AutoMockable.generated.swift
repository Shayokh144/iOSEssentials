// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import MoyaTest
import RxSwift
import RxCocoa















class NavigatableMock: Navigatable {

    //MARK: - show

    var showSceneSenderTransitionCallsCount = 0
    var showSceneSenderTransitionCalled: Bool {
        return showSceneSenderTransitionCallsCount > 0
    }
    var showSceneSenderTransitionReceivedArguments: (scene: Navigator.Scene, sender: UIViewController?, transition: Navigator.Transition)?
    var showSceneSenderTransitionReceivedInvocations: [(scene: Navigator.Scene, sender: UIViewController?, transition: Navigator.Transition)] = []
    var showSceneSenderTransitionClosure: ((Navigator.Scene, UIViewController?, Navigator.Transition) -> Void)?

    func show(scene: Navigator.Scene, sender: UIViewController?, transition: Navigator.Transition) {
        showSceneSenderTransitionCallsCount += 1
        showSceneSenderTransitionReceivedArguments = (scene: scene, sender: sender, transition: transition)
        showSceneSenderTransitionReceivedInvocations.append((scene: scene, sender: sender, transition: transition))
        showSceneSenderTransitionClosure?(scene, sender, transition)
    }

    //MARK: - dismiss

    var dismissSenderCallsCount = 0
    var dismissSenderCalled: Bool {
        return dismissSenderCallsCount > 0
    }
    var dismissSenderReceivedSender: UIViewController?
    var dismissSenderReceivedInvocations: [UIViewController?] = []
    var dismissSenderClosure: ((UIViewController?) -> Void)?

    func dismiss(sender: UIViewController?) {
        dismissSenderCallsCount += 1
        dismissSenderReceivedSender = sender
        dismissSenderReceivedInvocations.append(sender)
        dismissSenderClosure?(sender)
    }

    //MARK: - pop

    var popSenderCallsCount = 0
    var popSenderCalled: Bool {
        return popSenderCallsCount > 0
    }
    var popSenderReceivedSender: UIViewController?
    var popSenderReceivedInvocations: [UIViewController?] = []
    var popSenderClosure: ((UIViewController?) -> Void)?

    func pop(sender: UIViewController?) {
        popSenderCallsCount += 1
        popSenderReceivedSender = sender
        popSenderReceivedInvocations.append(sender)
        popSenderClosure?(sender)
    }

    //MARK: - popToRoot

    var popToRootSenderCallsCount = 0
    var popToRootSenderCalled: Bool {
        return popToRootSenderCallsCount > 0
    }
    var popToRootSenderReceivedSender: UIViewController?
    var popToRootSenderReceivedInvocations: [UIViewController?] = []
    var popToRootSenderClosure: ((UIViewController?) -> Void)?

    func popToRoot(sender: UIViewController?) {
        popToRootSenderCallsCount += 1
        popToRootSenderReceivedSender = sender
        popToRootSenderReceivedInvocations.append(sender)
        popToRootSenderClosure?(sender)
    }

}

