import Foundation

public struct EnvironmentInfo: Equatable, Codable, Sendable {
    public let processName: String
    public let processIdentifier: Int32
    public let systemUptime: TimeInterval
    public let isUnitTesting: Bool
    public let isUITesting: Bool
    public let isDebugBuild: Bool

    public init(
        processName: String,
        processIdentifier: Int32,
        systemUptime: TimeInterval,
        isUnitTesting: Bool,
        isUITesting: Bool,
        isDebugBuild: Bool
    ) {
        self.processName = processName
        self.processIdentifier = processIdentifier
        self.systemUptime = systemUptime
        self.isUnitTesting = isUnitTesting
        self.isUITesting = isUITesting
        self.isDebugBuild = isDebugBuild
    }

    public static var current: EnvironmentInfo {
        let configuration = DeviceConfigurationStore.current
        let processInfo = ProcessInfo.processInfo

        return EnvironmentInfo(
            processName: processInfo.processName,
            processIdentifier: processInfo.processIdentifier,
            systemUptime: processInfo.systemUptime,
            isUnitTesting: configuration.isUnitTesting,
            isUITesting: configuration.isUITesting,
            isDebugBuild: configuration.isDebugBuild
        )
    }
}
