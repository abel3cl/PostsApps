import Foundation

enum HTTPMethod: String {
    case get
    case post
    case patch
    case update
    case delete
}

public struct HTTPRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
    let pathComponents: [String]
    let queryParams: [String: String]

    init(url: String,
         method: HTTPMethod,
         headers: [String: String] = [:],
         body: Data? = nil,
         pathComponents: [String] = [],
         queryParams: [String: String] = [:]) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }

    public static func get(url: String) -> HTTPRequest {
        return HTTPRequest(url: url, method: .get)
    }
    public static func post(url: String) -> HTTPRequest {
        return HTTPRequest(url: url, method: .post)
    }

    public func with(headers: [String: String]? = nil,
                     body: Data? = nil,
                     pathComponents: [String]? = nil,
                     queryParams: [String: String]? = nil) -> HTTPRequest {
        return HTTPRequest(url: self.url,
                           method: self.method,
                           headers: self.headers + headers,
                           body: body ?? self.body,
                           pathComponents: self.pathComponents.appending(pathComponents ?? []),
                           queryParams: self.queryParams + queryParams)
    }

    public func with<T: Encodable>(encodable: T) throws -> HTTPRequest {
        let jsonHeader = ["Content-Type": "application/json"]
        let body = try JSONEncoder().encode(encodable)

        return HTTPRequest(url: self.url,
                           method: self.method,
                           headers: self.headers + jsonHeader,
                           body: body,
                           pathComponents: self.pathComponents,
                           queryParams: self.queryParams)
    }

    func build() throws -> URLRequest {

        guard var components = URLComponents(string: url) else {
            throw HTTPError.malformedURL(description: url)
        }
        let moreParams = queryParams.map(URLQueryItem.init)
        let allParams = (components.queryItems ?? []) + moreParams
        components.queryItems = allParams.sorted(by: { $0.name < $1.name })

        guard let url = components.url else {
            throw HTTPError.malformedURL(description: components.description)
        }

        let urlRequest = URLRequest(url: pathComponents.reduce(url, append))

        var request = headers.reduce(into: urlRequest, add)

        request.httpMethod = method.rawValue
        request.httpBody = body

        return request
    }

    private func add(request: inout URLRequest, header: (key: String, value: String)) {
        request.addValue(header.value, forHTTPHeaderField: header.key)
    }
    private func append(url: URL, pathComponent: String) -> URL {
        return url.appendingPathComponent(pathComponent)
    }
}
