import Foundation
import Testing

@testable import DevicePrism

@Suite("OSVersion")
struct OSVersionTests {
    @Test("Compares by major, minor and patch")
    func comparesComponents() {
        #expect(OSVersion.iOS(26) > OSVersion.iOS(18, 6, 2))
        #expect(OSVersion.iOS(18, 6) == OSVersion.iOS(18, 6, 0))
        #expect(OSVersion.iOS(18, 6, 1) > OSVersion.iOS(18, 6))
    }

    @Test("Formats the version for display")
    func formatsVersion() {
        #expect(OSVersion.iOS(26).description == "26.0")
        #expect(OSVersion.iOS(18, 6).description == "18.6")
        #expect(OSVersion.iOS(18, 6, 2).description == "18.6.2")
    }
}
