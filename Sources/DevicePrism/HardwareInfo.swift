import Foundation

public enum CPUArchitecture: String, Codable, Sendable {
    case arm64
    case x86_64
    case i386
    case unknown

    static var current: CPUArchitecture {
        #if arch(arm64)
            return .arm64
        #elseif arch(x86_64)
            return .x86_64
        #elseif arch(i386)
            return .i386
        #else
            return .unknown
        #endif
    }
}

public enum ThermalState: String, Codable, Sendable {
    case nominal
    case fair
    case serious
    case critical
    case unknown

    init(_ state: ProcessInfo.ThermalState) {
        switch state {
        case .nominal:
            self = .nominal
        case .fair:
            self = .fair
        case .serious:
            self = .serious
        case .critical:
            self = .critical
        @unknown default:
            self = .unknown
        }
    }
}

public struct HardwareInfo: Equatable, Codable, Sendable {
    public let processorCount: Int
    public let activeProcessorCount: Int
    public let cpuArchitecture: CPUArchitecture
    public let pointerSize: Int
    public let is64Bit: Bool
    public let thermalState: ThermalState

    public init(
        processorCount: Int,
        activeProcessorCount: Int,
        cpuArchitecture: CPUArchitecture,
        pointerSize: Int,
        is64Bit: Bool,
        thermalState: ThermalState
    ) {
        self.processorCount = processorCount
        self.activeProcessorCount = activeProcessorCount
        self.cpuArchitecture = cpuArchitecture
        self.pointerSize = pointerSize
        self.is64Bit = is64Bit
        self.thermalState = thermalState
    }

    public static var current: HardwareInfo {
        let processInfo = ProcessInfo.processInfo

        return HardwareInfo(
            processorCount: processInfo.processorCount,
            activeProcessorCount: processInfo.activeProcessorCount,
            cpuArchitecture: CPUArchitecture.current,
            pointerSize: MemoryLayout<UnsafeRawPointer>.size,
            is64Bit: MemoryLayout<Int>.size == 8,
            thermalState: ThermalState(processInfo.thermalState)
        )
    }
}
