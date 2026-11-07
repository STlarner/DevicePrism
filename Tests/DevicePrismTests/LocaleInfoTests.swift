import Testing

@testable import DevicePrism

@Suite("LocaleInfo")
struct LocaleInfoTests {
    @Test("Reports locale and calendar data")
    func reportsLocale() {
        let info = LocaleInfo.current

        #expect(!info.preferredLanguages.isEmpty)
        #expect(!info.calendarIdentifier.isEmpty)
        #expect(!info.timeZoneIdentifier.isEmpty)
        #expect(!info.decimalSeparator.isEmpty)
        #expect((1...7).contains(info.firstWeekday))
    }
}
