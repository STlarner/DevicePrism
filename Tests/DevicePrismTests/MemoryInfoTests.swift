import Testing

@testable import DevicePrism

@Suite("MemoryInfo")
struct MemoryInfoTests {
    @Test("Reports physical and resident memory")
    func reportsMemory() {
        let info = MemoryInfo.current

        #expect(info.physicalBytes > 0)
        #expect((info.residentBytes ?? 0) > 0)
    }
}
