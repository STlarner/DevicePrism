import Foundation
import Testing

@testable import DevicePrism

@Suite("Device")
struct DeviceTests {
    @Test("Encodes and decodes a snapshot")
    func encodesAndDecodes() throws {
        let device = Device.current
        let data = try JSONEncoder().encode(device)
        let decoded = try JSONDecoder().decode(Device.self, from: data)

        #expect(decoded == device)
    }

    @Test("Leaves UI sections out of the background snapshot")
    func backgroundSnapshot() {
        let device = Device.current

        #expect(device.display == nil)
        #expect(device.battery == nil)
        #expect(device.accessibility == nil)
        #expect(device.vendorIdentifier == nil)
    }

    @Test("Fills UI sections in the foreground snapshot")
    @MainActor
    func foregroundSnapshot() {
        let device = Device.foreground

        #expect(device.battery != nil)
        #expect(device.accessibility != nil)
    }
}
