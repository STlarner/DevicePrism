import Testing

@testable import DevicePrism

@Suite("DeviceIdentity")
struct DeviceIdentityTests {
    @Test("Reads a model identifier")
    func readsModelIdentifier() {
        let identity = DeviceIdentity.current

        #expect(!identity.modelIdentifier.isEmpty)
        #expect(!identity.model.isEmpty)
        #expect(identity.isPhysicalDevice == !identity.isSimulator)
    }

    @Test("Maps known model identifiers")
    func mapsKnownModels() {
        #expect(
            DeviceModelCatalog.name(for: "iPhone17,1") == "iPhone 16 Pro"
        )
        #expect(DeviceModelCatalog.name(for: "iPad16,4") ==
            "iPad Pro 11-inch (M4)")
        #expect(DeviceModelCatalog.name(for: "unknown") == nil)
    }

    @Test("Derives the device type from the identifier")
    func derivesDeviceType() {
        #expect(DeviceType(identifier: "iPhone17,1") == .iPhone)
        #expect(DeviceType(identifier: "iPad16,1") == .iPad)
        #expect(DeviceType(identifier: "Mac14,2") == .unknown)
    }
}
