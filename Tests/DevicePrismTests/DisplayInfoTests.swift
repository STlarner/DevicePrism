import Testing

@testable import DevicePrism

@Suite("DisplayInfo")
@MainActor
struct DisplayInfoTests {
    @Test("Reports a usable display when a scene exists")
    func reportsDisplay() {
        guard let info = DisplayInfo.current else {
            return
        }

        #expect(info.scale > 0)
        #expect(info.nativeScale > 0)
        #expect(info.maximumFramesPerSecond > 0)
        #expect(info.pointSize.width > 0)
        #expect(info.pointSize.height > 0)
    }
}
