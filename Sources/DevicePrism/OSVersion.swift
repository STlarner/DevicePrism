import Foundation

public struct OSVersion: Hashable, Codable, Comparable, Sendable,
    CustomStringConvertible
{
    public let major: Int
    public let minor: Int
    public let patch: Int

    public init(major: Int, minor: Int = 0, patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public static func iOS(
        _ major: Int,
        _ minor: Int = 0,
        _ patch: Int = 0
    ) -> OSVersion {
        OSVersion(major: major, minor: minor, patch: patch)
    }

    public var description: String {
        if patch > 0 {
            return "\(major).\(minor).\(patch)"
        }
        return "\(major).\(minor)"
    }

    public static func < (lhs: OSVersion, rhs: OSVersion) -> Bool {
        (lhs.major, lhs.minor, lhs.patch)
            < (rhs.major, rhs.minor, rhs.patch)
    }
}
