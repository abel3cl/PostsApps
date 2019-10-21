import Foundation

public protocol Storage {
    associatedtype StorableType: Codable

    func save(models: [StorableType])
    func get() -> StorageResult<[StorableType], StorageError>
}

public final class AnyStorage<StorableType: Codable>: Storage {

    private let _save: (_ models: [StorableType]) -> Void
    private let _get: () -> StorageResult<[StorableType], StorageError>

    public init<T: Storage>(_ wrapping: T) where T.StorableType == StorableType {
        self._save = wrapping.save
        self._get = wrapping.get
    }

    public func save(models: [StorableType]) {
        _save(models)
    }

    public func get() -> StorageResult<[StorableType], StorageError> {
        return _get()
    }
}

public enum StorageResult<T, Error> {
    case success(T, Date)
    case failure(Error)
}
