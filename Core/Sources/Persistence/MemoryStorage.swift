import Foundation

public final class MemoryStorage<StorableType: Codable>: Storage {
    private var date: Date?
    private var models: [StorableType] = []

    public init() {}

    public func save(models: [StorableType]) {
        self.date = Date()
        self.models.append(contentsOf: models)
    }

    public func get() -> StorageResult<[StorableType], StorageError> {
        if let date = date {
            return .success(models, date)
        } else {
            return .failure(StorageError.notFound)
        }
    }

}
