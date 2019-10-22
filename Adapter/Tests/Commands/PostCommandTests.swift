import XCTest
import Core
@testable import Adapter

final class PostCommandTests: XCTestCase {

    private static let context = AdapterContext(baseUrl: "baseUrl.com/api")
    private let commandFactory = PostAdapterCommandFactory(context: context)

    func test_getPost() {
        let client = HTTPClientMock.inspecting { request in
            XCTAssertEqual("GET", request.httpMethod)
            XCTAssertEqual("baseUrl.com/api/posts?", request.url?.absoluteString)
        }

        let command = commandFactory.getPost()
        command.perform(in: client, dispatcher: SyncDispatcher()) { _ in }
    }

}
