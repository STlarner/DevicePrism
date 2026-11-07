// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DevicePrism",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DevicePrism", targets: ["DevicePrism"])
    ],
    targets: [
        .target(
            name: "DevicePrism",
            resources: [.copy("Resources/PrivacyInfo.xcprivacy")]
        ),
        .testTarget(
            name: "DevicePrismTests",
            dependencies: ["DevicePrism"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
