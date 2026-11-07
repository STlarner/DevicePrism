import Darwin
import Foundation

public struct MemoryInfo: Equatable, Codable, Sendable {
    public let physicalBytes: UInt64
    public let residentBytes: UInt64?

    public init(physicalBytes: UInt64, residentBytes: UInt64?) {
        self.physicalBytes = physicalBytes
        self.residentBytes = residentBytes
    }

    public static var current: MemoryInfo {
        MemoryInfo(
            physicalBytes: ProcessInfo.processInfo.physicalMemory,
            residentBytes: residentBytes()
        )
    }

    private static func residentBytes() -> UInt64? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(
            MemoryLayout<mach_task_basic_info>.size
                / MemoryLayout<natural_t>.size
        )

        let result = withUnsafeMutablePointer(to: &info) { pointer in
            pointer.withMemoryRebound(
                to: integer_t.self,
                capacity: Int(count)
            ) { rebound in
                task_info(
                    mach_task_self_,
                    task_flavor_t(MACH_TASK_BASIC_INFO),
                    rebound,
                    &count
                )
            }
        }

        guard result == KERN_SUCCESS else {
            return nil
        }
        return info.resident_size
    }
}
