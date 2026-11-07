import Foundation
import Testing

@testable import DevicePrism

@Suite("AppInfo")
struct AppInfoTests {
    @Test("Reads standard bundle keys")
    func readsBundleKeys() {
        let info = AppInfo(
            infoDictionary: [
                "CFBundleName": "Demo",
                "CFBundleDisplayName": "Device Prism",
                "CFBundleShortVersionString": "1.2.3",
                "CFBundleVersion": "42",
                "MinimumOSVersion": "17.0",
                "CFBundleExecutable": "Demo",
                "CFBundleDevelopmentRegion": "en",
            ],
            fallbackName: "Fallback",
            bundleIdentifier: "com.example.demo"
        )

        #expect(info.name == "Demo")
        #expect(info.displayName == "Device Prism")
        #expect(info.version == "1.2.3")
        #expect(info.buildNumber == "42")
        #expect(info.minimumOSVersion == "17.0")
        #expect(info.executableName == "Demo")
        #expect(info.developmentRegion == "en")
        #expect(info.bundleIdentifier == "com.example.demo")
    }

    @Test("Falls back when keys are missing")
    func fallsBack() {
        let info = AppInfo(
            infoDictionary: [:],
            fallbackName: "Fallback",
            bundleIdentifier: nil
        )

        #expect(info.name == "Fallback")
        #expect(info.displayName == "Fallback")
        #expect(info.version == "0.0.0")
        #expect(info.buildNumber == "0")
        #expect(info.minimumOSVersion == nil)
    }
}
