import Foundation

final class HTTPClientMockExecutor: HTTPClientExecutorProtocol {
    let data: Data?
    let urlResponse: URLResponse?
    let error: Error?

    init(data: Data? = nil,
         urlResponse: URLResponse? = nil,
         error: Error? = nil) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    public func resume(request: URLRequest,
                       completion callback:@escaping (Data?, URLResponse?, Error?) -> Void) {
        callback(data, urlResponse, error)
    }
}
