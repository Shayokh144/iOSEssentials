//
//  AppViewModelTests.swift
//  MockNWPathMonitorTests
//
//  Created by Taher on 24/10/23.
//

@testable import MockNWPathMonitor
import XCTest
import Combine

final class AppViewModelTests: XCTestCase {

    var sut: AppViewModel!
    var mockNetworkPathMonitor: MockNetworkPathMonitor!
    var cancellable = Set<AnyCancellable>()

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
        sut.$networkStatus
            .dropFirst()
            .sink { [weak self] _ in
                XCTAssertTrue(self?.sut.networkStatus == .connected)
            }
            .store(in: &cancellable)
    }

    func testNetworkStatusWhenInternetIsNotConnected() throws {
        mockNetworkPathMonitor.currentNetworkStatus = .unsatisfied
        sut.$networkStatus
            .dropFirst()
            .sink { [weak self] _ in
                XCTAssertTrue(self?.sut.networkStatus == .notConnected)
            }
            .store(in: &cancellable)
    }
}
