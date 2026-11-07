# DevicePrism

DevicePrism gives an iOS app one snapshot of the device it runs on: the app,
the operating system, the hardware, storage, the locale, and the UI state that
affects how the app should behave.

```swift
import DevicePrism

let device = Device.current

print(device.identity.modelIdentifier)  // "iPhone17,1"
print(device.identity.modelName)        // "iPhone 16 Pro"
print(device.os.version)                // "18.6.2"
print(device.app.version)               // "1.4.2"
```

## Requirements

- iOS 17 or later
- Swift 6

## Installation

Add the package in Xcode, or add it to `Package.swift`:

```swift
.package(url: "https://github.com/STlarner/DevicePrism.git", exact: "0.1.0")
```

## Usage

### Read a single value

Every section has its own `current`, so reading one value does not build the
whole snapshot:

```swift
AppInfo.current.version
OSInfo.current.version
DeviceIdentity.current.modelIdentifier
StorageInfo.current.availableBytes
```

### Compare the OS version

```swift
if OSInfo.isAtLeast(.iOS(26)) {
    // iOS or iPadOS 26 or later
}
```

`isAtLeast` accepts major, minor and patch components: `.iOS(18, 6, 2)`. It
uses `ProcessInfo.isOperatingSystemAtLeast`, so it is a runtime check. If you
need to call an API introduced in a newer SDK, keep using `#available`.

### Read UI state

`Device.current` is safe to call from any thread and leaves the UI-dependent
fields empty. `Device.foreground` is main-actor isolated and fills display,
battery, accessibility and the vendor identifier:

```swift
@MainActor
func readScreen() {
    let device = Device.foreground
    print(device.display?.scale ?? 0)
    print(device.battery?.level ?? -1)
    print(device.accessibility?.isReduceMotionEnabled ?? false)
    print(device.vendorIdentifier?.uuidString ?? "nil")
}
```

`display` is `nil` when there is no foreground window scene, such as in a
widget or a background task.

### Export the snapshot

`Device` is `Codable`:

```swift
let data = try JSONEncoder().encode(Device.current)
```

### Configure test flags

The environment section does not guess whether the app is running tests or is
a debug build. Set the flags once at startup:

```swift
Device.configure(
    isDebugBuild: true,
    isUnitTesting: false,
    isUITesting: false
)
```

`isDebugBuild` defaults to the package's build configuration. `isUnitTesting`
defaults to the presence of `XCTestConfigurationFilePath`. Override both when
your app uses custom configurations or launch arguments.

## What is in the snapshot

| Section | Values |
| --- | --- |
| `app` | name, display name, bundle identifier, version, build, minimum OS, executable, development region |
| `identity` | model, model identifier, marketing name, localized model, device type, simulator and physical-device flags |
| `os` | name, version, major/minor/patch, low power mode |
| `hardware` | processor counts, CPU architecture, pointer size, 64-bit flag, thermal state |
| `memory` | physical memory, resident memory |
| `storage` | total, available, free, used and important-usage bytes |
| `locale` | preferred languages, language, region, currency, calendar, time zone, metric system, decimal separator, first weekday |
| `environment` | process name, PID, uptime, debug and testing flags |
| `display` | point and pixel sizes, scale, native scale, maximum frame rate, orientation, capture and dark-mode flags |
| `battery` | level, state, charging and fully-charged flags |
| `accessibility` | VoiceOver, bold text, reduce motion, reduce transparency, content size category |

## Model names

`modelIdentifier` comes from `hw.machine` (or `SIMULATOR_MODEL_IDENTIFIER` in
the simulator). `modelName` is a best-effort lookup into a catalog that ships
with the package. Unknown identifiers return `nil`, so new hardware never
produces a wrong name. Update `DeviceModelCatalog.swift` to add new devices.

## Privacy

The package reads values but does not send them anywhere. It ships a
`PrivacyInfo.xcprivacy` declaring the disk-space and system-boot-time APIs.

`identifierForVendor` is available through `Device.foreground.vendorIdentifier`.
It is privacy-sensitive, can be `nil`, and can change when the app is
reinstalled or the device changes.

## Demo

Open `Demo/DevicePrismDemo.xcodeproj` in Xcode and run it. The app lists every
value in the snapshot and copies the JSON representation to the clipboard.

## Tests

Run the package tests on an iOS simulator:

```sh
xcodebuild test -scheme DevicePrism \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## License

MIT. See `LICENSE`.
