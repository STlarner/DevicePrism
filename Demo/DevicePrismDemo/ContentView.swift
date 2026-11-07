import DevicePrism
import Foundation
import SwiftUI
import UIKit

@MainActor
struct ContentView: View {
    @State private var didCopy = false

    var body: some View {
        let device = Device.foreground
        NavigationStack {
            List {
                Section("App") {
                    row("Name", device.app.name)
                    row("Display name", device.app.displayName)
                    row("Bundle", device.app.bundleIdentifier ?? "nil")
                    row("Version", device.app.version)
                    row("Build", device.app.buildNumber)
                    row("Minimum OS", device.app.minimumOSVersion ?? "nil")
                    row("Executable", device.app.executableName ?? "nil")
                    row("Region", device.app.developmentRegion ?? "nil")
                }

                Section("Device") {
                    row("Model", device.identity.model)
                    row("Identifier", device.identity.modelIdentifier)
                    row(
                        "Marketing name",
                        device.identity.modelName ?? "Unknown"
                    )
                    row("Localized model", device.identity.localizedModel)
                    row("Type", device.identity.deviceType.rawValue)
                    row("Simulator", yesNo(device.identity.isSimulator))
                    row(
                        "Physical",
                        yesNo(device.identity.isPhysicalDevice)
                    )
                    row(
                        "Vendor ID",
                        device.vendorIdentifier?.uuidString ?? "nil"
                    )
                }

                Section("OS") {
                    row("Name", device.os.name)
                    row("Version", device.os.versionString)
                    row("Major", "\(device.os.majorVersion)")
                    row("Minor", "\(device.os.minorVersion)")
                    row("Patch", "\(device.os.patchVersion)")
                    row(
                        "Low power mode",
                        yesNo(device.os.isLowPowerModeEnabled)
                    )
                    row(
                        "At least iOS 26",
                        yesNo(device.os.isAtLeast(.iOS(26)))
                    )
                }

                Section("Hardware") {
                    row("Processors", "\(device.hardware.processorCount)")
                    row(
                        "Active processors",
                        "\(device.hardware.activeProcessorCount)"
                    )
                    row(
                        "Architecture",
                        device.hardware.cpuArchitecture.rawValue
                    )
                    row("Pointer size", "\(device.hardware.pointerSize)")
                    row("64-bit", yesNo(device.hardware.is64Bit))
                    row("Thermal state", device.hardware.thermalState.rawValue)
                }

                Section("Memory") {
                    row("Physical", bytes(device.memory.physicalBytes))
                    row("Resident", bytes(device.memory.residentBytes))
                }

                Section("Storage") {
                    row("Total", bytes(device.storage.totalBytes))
                    row("Available", bytes(device.storage.availableBytes))
                    row("Free", bytes(device.storage.freeBytes))
                    row("Used", bytes(device.storage.usedBytes))
                    row(
                        "Important usage",
                        bytes(device.storage.importantUsageBytes)
                    )
                }

                Section("Locale") {
                    row(
                        "Languages",
                        device.locale.preferredLanguages.joined(
                            separator: ", "
                        )
                    )
                    row("Language", device.locale.languageCode ?? "nil")
                    row("Region", device.locale.regionCode ?? "nil")
                    row("Currency", device.locale.currencyCode ?? "nil")
                    row(
                        "Currency symbol",
                        device.locale.currencySymbol ?? "nil"
                    )
                    row("Calendar", device.locale.calendarIdentifier)
                    row("Time zone", device.locale.timeZoneIdentifier)
                    row("UTC offset", "\(device.locale.timeZoneOffset)s")
                    row("Metric", yesNo(device.locale.usesMetricSystem))
                    row(
                        "Decimal separator",
                        device.locale.decimalSeparator
                    )
                    row("First weekday", "\(device.locale.firstWeekday)")
                }

                Section("Environment") {
                    row("Process", device.environment.processName)
                    row("PID", "\(device.environment.processIdentifier)")
                    row(
                        "Uptime",
                        "\(Int(device.environment.systemUptime))s"
                    )
                    row(
                        "Debug build",
                        yesNo(device.environment.isDebugBuild)
                    )
                    row(
                        "Unit testing",
                        yesNo(device.environment.isUnitTesting)
                    )
                    row(
                        "UI testing",
                        yesNo(device.environment.isUITesting)
                    )
                }

                Section("Display") {
                    if let display = device.display {
                        row("Points", size(display.pointSize))
                        row("Native pixels", size(display.nativePixelSize))
                        row("Scale", "\(display.scale)")
                        row("Native scale", "\(display.nativeScale)")
                        row(
                            "Max FPS",
                            "\(display.maximumFramesPerSecond)"
                        )
                        row(
                            "Orientation",
                            display.orientation.rawValue
                        )
                        row("Captured", yesNo(display.isCaptured))
                        row("Dark mode", yesNo(display.isDarkMode))
                    } else {
                        row("Display", "No active scene")
                    }
                }

                Section("Battery") {
                    if let battery = device.battery {
                        row(
                            "Level",
                            battery.level.map { "\(Int($0 * 100))%" }
                                ?? "Unknown"
                        )
                        row("State", battery.state.rawValue)
                        row("Charging", yesNo(battery.isCharging))
                        row(
                            "Fully charged",
                            yesNo(battery.isFullyCharged)
                        )
                    } else {
                        row("Battery", "Unavailable")
                    }
                }

                Section("Accessibility") {
                    if let accessibility = device.accessibility {
                        row(
                            "VoiceOver",
                            yesNo(accessibility.isVoiceOverRunning)
                        )
                        row(
                            "Bold text",
                            yesNo(accessibility.isBoldTextEnabled)
                        )
                        row(
                            "Reduce motion",
                            yesNo(accessibility.isReduceMotionEnabled)
                        )
                        row(
                            "Reduce transparency",
                            yesNo(
                                accessibility.isReduceTransparencyEnabled
                            )
                        )
                        row(
                            "Content size",
                            accessibility.contentSizeCategory
                        )
                    } else {
                        row("Accessibility", "Unavailable")
                    }
                }
            }
            .navigationTitle("DevicePrism")
            .toolbar {
                Button("Copy JSON") {
                    copyJSON(device)
                }
            }
            .alert("JSON copied", isPresented: $didCopy) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer(minLength: 16)
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }

    private func yesNo(_ value: Bool) -> String {
        value ? "Yes" : "No"
    }

    private func bytes(_ value: Int64?) -> String {
        guard let value else { return "nil" }
        return ByteCountFormatter.string(fromByteCount: value, countStyle: .file)
    }

    private func bytes(_ value: UInt64?) -> String {
        guard let value else { return "nil" }
        return ByteCountFormatter.string(
            fromByteCount: Int64(value),
            countStyle: .memory
        )
    }

    private func size(_ value: CGSize) -> String {
        "\(Int(value.width)) × \(Int(value.height))"
    }

    private func copyJSON(_ device: Device) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        guard let data = try? encoder.encode(device),
            let json = String(data: data, encoding: .utf8)
        else {
            return
        }

        UIPasteboard.general.string = json
        didCopy = true
    }
}
