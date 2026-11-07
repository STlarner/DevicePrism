import UIKit

public struct AccessibilityInfo: Equatable, Codable, Sendable {
    public let isVoiceOverRunning: Bool
    public let isBoldTextEnabled: Bool
    public let isReduceMotionEnabled: Bool
    public let isReduceTransparencyEnabled: Bool
    public let contentSizeCategory: String

    public init(
        isVoiceOverRunning: Bool,
        isBoldTextEnabled: Bool,
        isReduceMotionEnabled: Bool,
        isReduceTransparencyEnabled: Bool,
        contentSizeCategory: String
    ) {
        self.isVoiceOverRunning = isVoiceOverRunning
        self.isBoldTextEnabled = isBoldTextEnabled
        self.isReduceMotionEnabled = isReduceMotionEnabled
        self.isReduceTransparencyEnabled = isReduceTransparencyEnabled
        self.contentSizeCategory = contentSizeCategory
    }

    @MainActor
    public static var current: AccessibilityInfo {
        AccessibilityInfo(
            isVoiceOverRunning: UIAccessibility.isVoiceOverRunning,
            isBoldTextEnabled: UIAccessibility.isBoldTextEnabled,
            isReduceMotionEnabled: UIAccessibility.isReduceMotionEnabled,
            isReduceTransparencyEnabled:
                UIAccessibility.isReduceTransparencyEnabled,
            contentSizeCategory:
                UIApplication.shared.preferredContentSizeCategory.rawValue
        )
    }
}
