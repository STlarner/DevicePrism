import Foundation

public struct AppInfo: Equatable, Codable, Sendable {
    public let name: String
    public let displayName: String
    public let bundleIdentifier: String?
    public let version: String
    public let buildNumber: String
    public let minimumOSVersion: String?
    public let executableName: String?
    public let developmentRegion: String?

    public init(bundle: Bundle = .main) {
        self.init(
            infoDictionary: bundle.infoDictionary ?? [:],
            fallbackName: bundle.bundleURL.deletingPathExtension()
                .lastPathComponent,
            bundleIdentifier: bundle.bundleIdentifier
        )
    }

    init(
        infoDictionary: [String: Any],
        fallbackName: String,
        bundleIdentifier: String?
    ) {
        let name = infoDictionary["CFBundleName"] as? String ?? fallbackName

        self.name = name
        self.displayName =
            infoDictionary["CFBundleDisplayName"] as? String ?? name
        self.bundleIdentifier = bundleIdentifier
        self.version =
            infoDictionary["CFBundleShortVersionString"] as? String ?? "0.0.0"
        self.buildNumber = infoDictionary["CFBundleVersion"] as? String ?? "0"
        self.minimumOSVersion = infoDictionary["MinimumOSVersion"] as? String
        self.executableName = infoDictionary["CFBundleExecutable"] as? String
        self.developmentRegion =
            infoDictionary["CFBundleDevelopmentRegion"] as? String
    }

    public static var current: AppInfo {
        AppInfo()
    }
}
