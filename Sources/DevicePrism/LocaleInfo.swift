import Foundation

public struct LocaleInfo: Equatable, Codable, Sendable {
    public let preferredLanguages: [String]
    public let languageCode: String?
    public let regionCode: String?
    public let currencyCode: String?
    public let currencySymbol: String?
    public let calendarIdentifier: String
    public let timeZoneIdentifier: String
    public let timeZoneOffset: Int
    public let usesMetricSystem: Bool
    public let decimalSeparator: String
    public let firstWeekday: Int

    public init(
        preferredLanguages: [String],
        languageCode: String?,
        regionCode: String?,
        currencyCode: String?,
        currencySymbol: String?,
        calendarIdentifier: String,
        timeZoneIdentifier: String,
        timeZoneOffset: Int,
        usesMetricSystem: Bool,
        decimalSeparator: String,
        firstWeekday: Int
    ) {
        self.preferredLanguages = preferredLanguages
        self.languageCode = languageCode
        self.regionCode = regionCode
        self.currencyCode = currencyCode
        self.currencySymbol = currencySymbol
        self.calendarIdentifier = calendarIdentifier
        self.timeZoneIdentifier = timeZoneIdentifier
        self.timeZoneOffset = timeZoneOffset
        self.usesMetricSystem = usesMetricSystem
        self.decimalSeparator = decimalSeparator
        self.firstWeekday = firstWeekday
    }

    public static var current: LocaleInfo {
        let locale = Locale.current
        let calendar = Calendar.current
        let timeZone = TimeZone.current
        let currencyCode = locale.currency?.identifier

        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode

        return LocaleInfo(
            preferredLanguages: Locale.preferredLanguages,
            languageCode: locale.language.languageCode?.identifier,
            regionCode: locale.region?.identifier,
            currencyCode: currencyCode,
            currencySymbol: formatter.currencySymbol,
            calendarIdentifier: String(describing: calendar.identifier),
            timeZoneIdentifier: timeZone.identifier,
            timeZoneOffset: timeZone.secondsFromGMT(),
            usesMetricSystem: locale.measurementSystem == .metric,
            decimalSeparator: locale.decimalSeparator ?? ".",
            firstWeekday: calendar.firstWeekday
        )
    }
}
