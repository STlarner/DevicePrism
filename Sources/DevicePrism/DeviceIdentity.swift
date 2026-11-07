import Foundation

public enum DeviceType: String, CaseIterable, Codable, Sendable {
    case iPhone
    case iPad
    case unknown

    init(identifier: String) {
        if identifier.hasPrefix("iPhone") {
            self = .iPhone
        } else if identifier.hasPrefix("iPad") {
            self = .iPad
        } else {
            self = .unknown
        }
    }

    var modelName: String {
        switch self {
        case .iPhone:
            return "iPhone"
        case .iPad:
            return "iPad"
        case .unknown:
            return "Unknown"
        }
    }
}

public struct DeviceIdentity: Equatable, Codable, Sendable {
    public let model: String
    public let modelIdentifier: String
    public let modelName: String?
    public let localizedModel: String
    public let deviceType: DeviceType
    public let isSimulator: Bool
    public let isPhysicalDevice: Bool

    public init(
        model: String,
        modelIdentifier: String,
        modelName: String?,
        localizedModel: String,
        deviceType: DeviceType,
        isSimulator: Bool,
        isPhysicalDevice: Bool
    ) {
        self.model = model
        self.modelIdentifier = modelIdentifier
        self.modelName = modelName
        self.localizedModel = localizedModel
        self.deviceType = deviceType
        self.isSimulator = isSimulator
        self.isPhysicalDevice = isPhysicalDevice
    }

    public static var current: DeviceIdentity {
        let identifier = Self.identifier()
        let deviceType = DeviceType(identifier: identifier)

        return DeviceIdentity(
            model: deviceType.modelName,
            modelIdentifier: identifier,
            modelName: DeviceModelCatalog.name(for: identifier),
            localizedModel: deviceType.modelName,
            deviceType: deviceType,
            isSimulator: Self.isSimulator,
            isPhysicalDevice: !Self.isSimulator
        )
    }

    private static func identifier() -> String {
        #if targetEnvironment(simulator)
            if let identifier = ProcessInfo.processInfo.environment[
                "SIMULATOR_MODEL_IDENTIFIER"
            ] {
                return identifier
            }
        #endif
        return Sysctl.machine()
    }

    private static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
}
