import Foundation
import os

public struct DeviceConfiguration: Equatable, Sendable {
    public var isDebugBuild: Bool
    public var isUnitTesting: Bool
    public var isUITesting: Bool

    public init() {
        self.isDebugBuild = Self.defaultIsDebugBuild
        self.isUnitTesting = Self.defaultIsUnitTesting
        self.isUITesting = false
    }

    public init(
        isDebugBuild: Bool,
        isUnitTesting: Bool,
        isUITesting: Bool
    ) {
        self.isDebugBuild = isDebugBuild
        self.isUnitTesting = isUnitTesting
        self.isUITesting = isUITesting
    }

    static var defaultIsDebugBuild: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    static var defaultIsUnitTesting: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"]
            != nil
    }
}

enum DeviceConfigurationStore {
    private static let lock = OSAllocatedUnfairLock(
        initialState: DeviceConfiguration()
    )

    static var current: DeviceConfiguration {
        lock.withLock { $0 }
    }

    static func update(_ update: @Sendable (inout DeviceConfiguration) -> Void) {
        lock.withLock { update(&$0) }
    }
}
