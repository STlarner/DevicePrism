import Testing

@testable import DevicePrism

@Suite("BatteryInfo")
@MainActor
struct BatteryInfoTests {
    @Test("Reads a level between zero and one")
    func readsLevel() {
        let info = BatteryInfo.current

        if let level = info.level {
            #expect((0...1).contains(level))
        }
        #expect(info.isCharging == (info.state == .charging))
        #expect(info.isFullyCharged == (info.state == .full))
    }
}
