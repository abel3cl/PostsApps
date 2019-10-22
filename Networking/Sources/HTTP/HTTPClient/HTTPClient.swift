import Foundation

public typealias HTTPResult = (data: Data?, statusCode: Int)

public protocol HTTPClientProtocol {
    func request(_ request: HTTPRequest, completion: @escaping (Result<HTTPResult, Error>) -> Void)
}

public struct HTTPClient {

    private let executor: HTTPClientExecutorProtocol
    public init(executor: HTTPClientExecutorProtocol = HTTPClientExecutor()) {
        self.executor = executor
    }
}

extension HTTPClient: HTTPClientProtocol {
    public func request(_ request: HTTPRequest, completion: @escaping (Result<HTTPResult, Error>) -> Void) {
        do {
            let request = try request.build()

            executor.resume(request: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let response = response as? HTTPURLResponse else {
                        completion(.failure(HTTPError.invalidResponse))
                        return
                    }
                    if response.statusCode >= 200 && response.statusCode <= 300 {
                        completion(.success((data, response.statusCode)))
                    } else {
                        completion(.failure(HTTPError.error(data: data)))
                    }
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
