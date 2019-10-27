import XCTest
@testable import Networking

final class HTTPRequestTests: XCTestCase {

    func test_build_returnsRequest() {
        do {
            let request = HTTPRequest
                .get(url: "https://baseUrl.com")
                .with(headers: ["cache-control": "no-cache"],
                      pathComponents: ["api", "test"],
                      queryParams: ["test": "true",
                                    "abc": "123"])
            let urlRequest = try request.build()
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://baseUrl.com/api/test?abc=123&test=true")
            XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Cache-Control"], "no-cache")
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func test_withEncodable_acceptsJson() {
        let person = Person(name: "Abel")
        do {
            let request = try HTTPRequest
                .get(url: "https://baseUrl.com")
                .with(encodable: person)
            let urlRequest = try request.build()

            XCTAssertNotNil(urlRequest.httpBody)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Content-Type"], "application/json")
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func test_post_returnsPOST() {

        let request = HTTPRequest
            .post(url: "https://baseUrl.com")
        do {
            let urlRequest = try request.build()
            XCTAssertNil(urlRequest.httpBody)
            XCTAssertEqual(urlRequest.httpMethod, "POST")
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func test_invalid_throwsMalformedURl() {
        let request = HTTPRequest
            .post(url: "baseUrl^fail")
        XCTAssertThrowsError(try request.build())
    }
}


private struct Person: Encodable {
    let name: String
}
