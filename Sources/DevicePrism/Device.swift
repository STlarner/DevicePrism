import Foundation
import UIKit

public struct Device: Equatable, Codable, Sendable {
    public let app: AppInfo
    public let identity: DeviceIdentity
    public let os: OSInfo
    public let hardware: HardwareInfo
    public let memory: MemoryInfo
    public let storage: StorageInfo
    public let locale: LocaleInfo
    public let environment: EnvironmentInfo
    public let display: DisplayInfo?
    public let battery: BatteryInfo?
    public let accessibility: AccessibilityInfo?
    public let vendorIdentifier: UUID?

    init(
        app: AppInfo,
        identity: DeviceIdentity,
        os: OSInfo,
        hardware: HardwareInfo,
        memory: MemoryInfo,
        storage: StorageInfo,
        locale: LocaleInfo,
        environment: EnvironmentInfo,
        display: DisplayInfo?,
        battery: BatteryInfo?,
        accessibility: AccessibilityInfo?,
        vendorIdentifier: UUID?
    ) {
        self.app = app
        self.identity = identity
        self.os = os
        self.hardware = hardware
        self.memory = memory
        self.storage = storage
        self.locale = locale
        self.environment = environment
        self.display = display
        self.battery = battery
        self.accessibility = accessibility
        self.vendorIdentifier = vendorIdentifier
    }

    public static var current: Device {
        Device(
            app: .current,
            identity: .current,
            os: .current,
            hardware: .current,
            memory: .current,
            storage: .current,
            locale: .current,
            environment: .current,
            display: nil,
            battery: nil,
            accessibility: nil,
            vendorIdentifier: nil
        )
    }

    @MainActor
    public static var foreground: Device {
        Device(
            app: .current,
            identity: .current,
            os: .current,
            hardware: .current,
            memory: .current,
            storage: .current,
            locale: .current,
            environment: .current,
            display: .current,
            battery: .current,
            accessibility: .current,
            vendorIdentifier: UIDevice.current.identifierForVendor
        )
    }

    public static func configure(
        isDebugBuild: Bool? = nil,
        isUnitTesting: Bool? = nil,
        isUITesting: Bool? = nil
    ) {
        DeviceConfigurationStore.update { configuration in
            if let isDebugBuild {
                configuration.isDebugBuild = isDebugBuild
            }
            if let isUnitTesting {
                configuration.isUnitTesting = isUnitTesting
            }
            if let isUITesting {
                configuration.isUITesting = isUITesting
            }
        }
    }
}
