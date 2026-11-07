import Testing

@testable import DevicePrism

@Suite("EnvironmentInfo")
struct EnvironmentInfoTests {
    @Test("Reports process data")
    func reportsProcess() {
        let info = EnvironmentInfo.current

        #expect(!info.processName.isEmpty)
        #expect(info.processIdentifier > 0)
        #expect(info.systemUptime > 0)
    }
}
