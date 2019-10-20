import Foundation

public enum AdapterError: Error {
    case noConection
    // specific errors from API
    // ...
    case original(error: Error)
}
