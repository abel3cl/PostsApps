import Foundation

public final class FileStorage<StorableType: Codable>: Storage {

    let subpath: String
    let documents: URL?

    public init?(subpath: String = "\(String(describing: StorableType.self))") {
        self.subpath = subpath

        documents = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
            appropriateFor: nil, create: false).appendingPathComponent(subpath)
        let path = documents?.absoluteString ?? ""
        print(path)
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path,
                                                withIntermediateDirectories: true,
                                                attributes: [FileAttributeKey.modificationDate : Date()])
            } catch {
                print(error)
            }
        }

    }
    
    public func save(models: [StorableType]) {
        guard let documents = documents,
            let data = try? JSONEncoder().encode(models) else { return }
        do {
            try FileManager.default.setAttributes([FileAttributeKey.modificationDate : Date()], ofItemAtPath: documents.path)
            try data.write(to: documents)
        } catch {
            print(error)
        }
    }

    public func get() -> StorageResult<[StorableType], StorageError> {
        do {
            guard let documents = documents else { return .failure(StorageError.notFound) }
            let data = try Data(contentsOf: documents)
            let models = try JSONDecoder().decode([StorableType].self, from: data)
            let modificationDate = try FileManager.default.attributesOfItem(atPath: documents.path)[FileAttributeKey.modificationDate] as? Date ?? Date()
            print(modificationDate)

            return .success(models, modificationDate)
        } catch {
            return .failure(StorageError.original(error: error))
        }
    }
}

public enum StorageError: Error {
    case notFound
    case original(error: Error)
}
