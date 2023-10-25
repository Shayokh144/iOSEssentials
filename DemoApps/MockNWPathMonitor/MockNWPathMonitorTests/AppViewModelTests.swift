//
//  AppViewModelTests.swift
//  MockNWPathMonitorTests
//
//  Created by Taher on 24/10/23.
//

@testable import MockNWPathMonitor
import XCTest

final class AppViewModelTests: XCTestCase {

    var sut: AppViewModel!
    var mockNetworkPathMonitor: MockNetworkPathMonitor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkPathMonitor = MockNetworkPathMonitor()
        sut = AppViewModel(networkMonitor: mockNetworkPathMonitor)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNetworkPathMonitor = nil
        try super.tearDownWithError()
    }

    func testNetworkStatusWhenInternetIsConnected() throws {
        mockNetworkPathMonitor.currentNetworkStatus = .satisfied
        let expectation = XCTestExpectation(description: "testNetworkStatusWhenInternetIsConnected")
        mockNetworkPathMonitor.start(queue: DispatchQueue.global())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(sut.networkStatus == .connected)
    }

    func testNetworkStatusWhenInternetIsNotConnected() throws {
        mockNetworkPathMonitor.currentNetworkStatus = .unsatisfied
        let expectation = XCTestExpectation(description: "testNetworkStatusWhenInternetIsNotConnected")
        mockNetworkPathMonitor.start(queue: DispatchQueue.global())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(sut.networkStatus == .notConnected)
    }
}
