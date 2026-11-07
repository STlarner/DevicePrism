import Testing

@testable import DevicePrism

@Suite("HardwareInfo")
struct HardwareInfoTests {
    @Test("Reports processor and pointer facts")
    func reportsFacts() {
        let info = HardwareInfo.current

        #expect(info.processorCount > 0)
        #expect(info.activeProcessorCount > 0)
        #expect(info.processorCount >= info.activeProcessorCount)
        #expect(info.pointerSize == 8)
        #expect(info.is64Bit)
    }
}
