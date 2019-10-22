import Core

final class MemoryStorage<StorableType: Codable>: Storage {
    var models: [StorableType] = []
    var result: StorageResult<[StorableType], StorageError>

    init(mockResult: StorageResult<[StorableType], StorageError>) {
        self.result = mockResult
    }
    func save(models: [StorableType]) {
//        self.models.append(models)

    }

    func get() -> StorageResult<[StorableType], StorageError> {
        return result
    }



    
}
