import Foundation

public final class FileStorage<StorableType: Codable>: Storage {

    let subpath: String
    let documentName: String = "Posts.json"
    let documents: URL?

    public init?(subpath: String = "\(String(describing: StorableType.self))") {
        self.subpath = subpath

        documents = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                 appropriateFor: nil, create: false)
            .appendingPathComponent(subpath, isDirectory: true)
            .appendingPathComponent(documentName)
        let path = documents?.path ?? ""

        if !FileManager.default.fileExists(atPath: path) {
            let result = FileManager.default.createFile(atPath: path,
                                           contents: nil,
                                           attributes: [FileAttributeKey.modificationDate: Date()])
            print("file created")
            print(result)
        }

    }

    public func save(models: [StorableType]) {
        guard let documents = documents,
            let data = try? JSONEncoder().encode(models) else { return }
        do {
            try data.write(to: documents)
            try FileManager.default.setAttributes([FileAttributeKey.modificationDate: Date()], ofItemAtPath: documents.path)

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
