import Testing

@testable import DevicePrism

@Suite("DeviceConfiguration", .serialized)
struct DeviceConfigurationTests {
    @Test("Overrides environment flags")
    func overridesFlags() {
        Device.configure(
            isDebugBuild: true,
            isUnitTesting: true,
            isUITesting: true
        )

        let info = EnvironmentInfo.current
        #expect(info.isDebugBuild)
        #expect(info.isUnitTesting)
        #expect(info.isUITesting)

        Device.configure(
            isDebugBuild: false,
            isUnitTesting: false,
            isUITesting: false
        )
    }
}
