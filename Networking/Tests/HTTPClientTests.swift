import XCTest
@testable import Networking

final class HTTPClientTests: XCTestCase {

    func test_200_completesDataAndStatusCode() {
        let url = URL(string: "url")!
        let data = "abc".data(using: .utf8)
        let urlResponse = HTTPURLResponse(url: url,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)
        let executor = HTTPClientMockExecutor(data: data, urlResponse: urlResponse)

        let client = HTTPClient(executor: executor)

        let completion: (Result<HTTPResult, Error>) -> Void = { result in
            if case let .success(httpResult) = result {
                XCTAssertNotNil(httpResult.data)
                XCTAssertEqual(httpResult.statusCode, 200)
            } else {
                XCTFail(String(describing: result))
            }
        }
        client.request(HTTPRequest.get(url: "url"), completion: completion)
    }

    func test_noHTTPResponse_throwsInvalidResponse() {
        let data = "abc".data(using: .utf8)!

        let urlResponse = URLResponse()
        let executor = HTTPClientMockExecutor(data: data, urlResponse: urlResponse)

        let client = HTTPClient(executor: executor)

        let completion: (Result<HTTPResult, Error>) -> Void = { result in
            if case .failure(HTTPError.invalidResponse) = result {
            } else {
                XCTFail(String(describing: result))
            }
        }
        client.request(HTTPRequest.get(url: "url"), completion: completion)
    }

    func test_500_completesError() {
        let url = URL(string: "url")!
        let data = "abc".data(using: .utf8)
        let urlResponse = HTTPURLResponse(url: url,
                                          statusCode: 500,
                                          httpVersion: nil,
                                          headerFields: nil)
        let executor = HTTPClientMockExecutor(data: data, urlResponse: urlResponse)

        let client = HTTPClient(executor: executor)

        let completion: (Result<HTTPResult, Error>) -> Void = { result in
            if case let .failure(HTTPError.error(data)) = result {
                XCTAssertNotNil(data)
            } else {
                XCTFail(String(describing: result))
            }
        }
        client.request(HTTPRequest.get(url: "url"), completion: completion)

    }
}
