import UIKit

public struct BatteryInfo: Equatable, Codable, Sendable {
    public enum State: String, Codable, Sendable {
        case unknown
        case unplugged
        case charging
        case full

        init(_ state: UIDevice.BatteryState) {
            switch state {
            case .unknown:
                self = .unknown
            case .unplugged:
                self = .unplugged
            case .charging:
                self = .charging
            case .full:
                self = .full
            @unknown default:
                self = .unknown
            }
        }
    }

    public let level: Float?
    public let state: State

    public var isCharging: Bool { state == .charging }
    public var isFullyCharged: Bool { state == .full }

    public init(level: Float?, state: State) {
        self.level = level
        self.state = state
    }

    @MainActor
    public static var current: BatteryInfo {
        let device = UIDevice.current
        let wasEnabled = device.isBatteryMonitoringEnabled

        device.isBatteryMonitoringEnabled = true
        defer { device.isBatteryMonitoringEnabled = wasEnabled }

        let level = device.batteryLevel
        return BatteryInfo(
            level: level >= 0 ? level : nil,
            state: State(device.batteryState)
        )
    }
}
