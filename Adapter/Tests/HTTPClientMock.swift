@testable import Networking
@testable import Adapter

struct SyncDispatcher: Dispatcher {
    func dispatch<T>(work: @escaping (_ completion:  @escaping (T) -> Void) -> Void, completion: @escaping (T) -> Void) {
        work(completion)        
    }
}

final class HTTPClientMock: HTTPClientProtocol {

    let callback: (URLRequest) throws -> Result<HTTPResult, Error>

    init(callback: @escaping (URLRequest) throws -> Result<HTTPResult, Error>) {
        self.callback = callback
    }

    static func inspecting(response: Result<HTTPResult, Error> = .failure(HTTPError.invalidResponse),
                           callback: @escaping (URLRequest) -> Void = { _ in }) -> HTTPClientProtocol {

        return HTTPClientMock { request in
            callback(request)
            return response
        }
    }

    func request(_ request: HTTPRequest, completion: @escaping (Result<HTTPResult, Error>) -> Void) {
        do {
            let result = try self.callback(request.build())
            completion(result)
        } catch {
            completion(.failure(error))
        }
    }
}
