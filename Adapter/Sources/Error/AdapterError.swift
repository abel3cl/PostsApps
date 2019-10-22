import Foundation

public enum AdapterError: Error {
    case noConection
    case timeOut
    // specific errors from API
    // ...
    case original(error: Error)
}
