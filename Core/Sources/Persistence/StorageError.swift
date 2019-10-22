import Foundation

public enum StorageError: Error {
    case notFound
    case original(error: Error)
}
