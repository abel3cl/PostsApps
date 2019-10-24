import Foundation
import Swifter

enum HTTPMethod {
    case POST
    case GET
    case DELETE
    case PUT
}

final class Stubs {

    private let server = HttpServer()

    func setUp() throws {
        try server.start(9080)
        setupStub(url: StubUrls.Post.get, filename: "posts_valid")
    }

    func tearDown() {
        server.stop()
    }
}

extension Stubs {

    func setupStub(url: String, filename: String? = nil, method: HTTPMethod = .GET, statusCode: Int = 200) {

        let response: ((HttpRequest) -> HttpResponse) = { _ in
            if let filename = filename, statusCode == 200 {
                let json = JsonUtils.load(file: filename)
                return HttpResponse.ok(.json(json as AnyObject))
            } else {
                return HttpResponse.internalServerError
            }
        }

        switch method {
        case .GET: server.GET[url] = response
        case .POST: server.POST[url] = response
        case .DELETE: server.DELETE[url] = response
        case .PUT: server.PUT[url] = response
        }
    }
}
