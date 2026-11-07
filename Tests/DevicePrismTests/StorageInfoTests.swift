import Testing

@testable import DevicePrism

@Suite("StorageInfo")
struct StorageInfoTests {
    @Test("Reports disk capacity")
    func reportsCapacity() {
        let info = StorageInfo.current

        #expect((info.totalBytes ?? 0) > 0)
        #expect((info.availableBytes ?? 0) >= 0)

        if let total = info.totalBytes, let available = info.availableBytes {
            #expect(available <= total)
        }
    }
}
