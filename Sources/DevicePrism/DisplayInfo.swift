import UIKit

public enum DisplayOrientation: String, Codable, Sendable {
    case portrait
    case portraitUpsideDown
    case landscapeLeft
    case landscapeRight
    case unknown

    init(_ orientation: UIInterfaceOrientation) {
        switch orientation {
        case .portrait:
            self = .portrait
        case .portraitUpsideDown:
            self = .portraitUpsideDown
        case .landscapeLeft:
            self = .landscapeLeft
        case .landscapeRight:
            self = .landscapeRight
        @unknown default:
            self = .unknown
        }
    }
}

public struct DisplayInfo: Equatable, Codable, Sendable {
    public let pointSize: CGSize
    public let nativePixelSize: CGSize
    public let scale: CGFloat
    public let nativeScale: CGFloat
    public let maximumFramesPerSecond: Int
    public let orientation: DisplayOrientation
    public let isCaptured: Bool
    public let isDarkMode: Bool

    public init(
        pointSize: CGSize,
        nativePixelSize: CGSize,
        scale: CGFloat,
        nativeScale: CGFloat,
        maximumFramesPerSecond: Int,
        orientation: DisplayOrientation,
        isCaptured: Bool,
        isDarkMode: Bool
    ) {
        self.pointSize = pointSize
        self.nativePixelSize = nativePixelSize
        self.scale = scale
        self.nativeScale = nativeScale
        self.maximumFramesPerSecond = maximumFramesPerSecond
        self.orientation = orientation
        self.isCaptured = isCaptured
        self.isDarkMode = isDarkMode
    }

    @MainActor
    public static var current: DisplayInfo? {
        guard let scene = activeScene else {
            return nil
        }
        let screen = scene.screen

        return DisplayInfo(
            pointSize: screen.bounds.size,
            nativePixelSize: screen.nativeBounds.size,
            scale: screen.scale,
            nativeScale: screen.nativeScale,
            maximumFramesPerSecond: screen.maximumFramesPerSecond,
            orientation: DisplayOrientation(scene.interfaceOrientation),
            isCaptured: screen.isCaptured,
            isDarkMode: scene.traitCollection.userInterfaceStyle == .dark
        )
    }

    @MainActor
    private static var activeScene: UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes.compactMap {
            $0 as? UIWindowScene
        }
        return scenes.first { $0.activationState == .foregroundActive }
            ?? scenes.first
    }
}
