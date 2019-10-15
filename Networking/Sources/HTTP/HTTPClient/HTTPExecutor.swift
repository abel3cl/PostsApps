import Foundation

public protocol HTTPClientExecutorProtocol {
    func resume(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

public final class HTTPClientExecutor: NSObject, HTTPClientExecutorProtocol {
    private lazy var session: URLSession = {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()

    public func resume(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.dataTask(with: request, completionHandler: completion).resume()
    }
}

extension HTTPClientExecutor: URLSessionDelegate {}
