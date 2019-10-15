import Foundation

enum HTTPError: Error {
    case malformedURL(description: String)
    case invalidResponse
    case error(data: Data?)
    case invalidJson
}
