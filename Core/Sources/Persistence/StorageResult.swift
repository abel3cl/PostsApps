import Foundation

public enum StorageResult<T, Error> {
    case success(T, Date)
    case failure(Error)
}
