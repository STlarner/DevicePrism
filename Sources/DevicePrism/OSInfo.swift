import Foundation

public struct OSInfo: Equatable, Codable, Sendable {
    public let name: String
    public let version: OSVersion
    public let isLowPowerModeEnabled: Bool

    public var versionString: String { version.description }
    public var majorVersion: Int { version.major }
    public var minorVersion: Int { version.minor }
    public var patchVersion: Int { version.patch }

    public init(
        name: String,
        version: OSVersion,
        isLowPowerModeEnabled: Bool
    ) {
        self.name = name
        self.version = version
        self.isLowPowerModeEnabled = isLowPowerModeEnabled
    }

    public static var current: OSInfo {
        let processInfo = ProcessInfo.processInfo
        let version = processInfo.operatingSystemVersion
        let deviceType = DeviceIdentity.current.deviceType

        return OSInfo(
            name: deviceType == .iPad ? "iPadOS" : "iOS",
            version: OSVersion(
                major: version.majorVersion,
                minor: version.minorVersion,
                patch: version.patchVersion
            ),
            isLowPowerModeEnabled: processInfo.isLowPowerModeEnabled
        )
    }

    public func isAtLeast(_ version: OSVersion) -> Bool {
        self.version >= version
    }

    public static func isAtLeast(_ version: OSVersion) -> Bool {
        current.isAtLeast(version)
    }
}
