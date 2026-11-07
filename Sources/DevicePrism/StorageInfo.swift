import Foundation

public struct StorageInfo: Equatable, Codable, Sendable {
    public let totalBytes: Int64?
    public let availableBytes: Int64?
    public let freeBytes: Int64?
    public let usedBytes: Int64?
    public let importantUsageBytes: Int64?

    public init(
        totalBytes: Int64?,
        availableBytes: Int64?,
        freeBytes: Int64?,
        usedBytes: Int64?,
        importantUsageBytes: Int64?
    ) {
        self.totalBytes = totalBytes
        self.availableBytes = availableBytes
        self.freeBytes = freeBytes
        self.usedBytes = usedBytes
        self.importantUsageBytes = importantUsageBytes
    }

    public static var current: StorageInfo {
        let path = NSHomeDirectory()
        let attributes = try? FileManager.default.attributesOfFileSystem(
            forPath: path
        )
        let total = (attributes?[.systemSize] as? NSNumber)?.int64Value
        let free = (attributes?[.systemFreeSize] as? NSNumber)?.int64Value

        let url = URL(fileURLWithPath: path)
        let values = try? url.resourceValues(forKeys: [
            .volumeAvailableCapacityKey,
            .volumeAvailableCapacityForImportantUsageKey,
        ])
        let available = values?.volumeAvailableCapacity.map(Int64.init)
        let importantUsage = values?.volumeAvailableCapacityForImportantUsage

        let used = total.flatMap { total in
            available.map { max(0, total - $0) }
        }

        return StorageInfo(
            totalBytes: total,
            availableBytes: available,
            freeBytes: free,
            usedBytes: used,
            importantUsageBytes: importantUsage
        )
    }
}
