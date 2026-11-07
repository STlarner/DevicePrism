import Testing

@testable import DevicePrism

@Suite("OSInfo")
struct OSInfoTests {
    @Test("Reports the current version")
    func reportsCurrentVersion() {
        let info = OSInfo.current

        #expect(info.majorVersion >= 17)
        #expect(info.isAtLeast(.iOS(17)))
        #expect(!info.isAtLeast(.iOS(999)))
        #expect(info.versionString == "\(info.version)")
    }

    @Test("Has a platform name")
    func hasPlatformName() {
        #expect(!OSInfo.current.name.isEmpty)
    }
}
