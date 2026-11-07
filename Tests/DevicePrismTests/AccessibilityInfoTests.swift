import Testing

@testable import DevicePrism

@Suite("AccessibilityInfo")
@MainActor
struct AccessibilityInfoTests {
    @Test("Reads the preferred content size category")
    func readsContentSizeCategory() {
        let info = AccessibilityInfo.current

        #expect(!info.contentSizeCategory.isEmpty)
    }
}
