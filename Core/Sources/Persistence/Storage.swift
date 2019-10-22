import Foundation

public protocol Storage {
    associatedtype StorableType: Codable

    func save(models: [StorableType])
    func get() -> StorageResult<[StorableType], StorageError>
}

public final class AnyStorage<StorableType: Codable>: Storage {

    private let _save: (_ models: [StorableType]) -> Void
    private let _get: () -> StorageResult<[StorableType], StorageError>
    private let dispatcher: Dispatcher

    public init<T: Storage>(_ wrapping: T,
                            dispatcher: Dispatcher = AsyncDispatcher()) where T.StorableType == StorableType {
        self._save = wrapping.save
        self._get = wrapping.get
        self.dispatcher = dispatcher
    }

    public func save(models: [StorableType]) {
        dispatcher.dispatch { [weak self] in
            self?._save(models)
        }
    }

    public func get() -> StorageResult<[StorableType], StorageError> {
        return _get()
    }
}
