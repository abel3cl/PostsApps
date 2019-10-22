import XCTest
import Core
@testable import Adapter

final class UserCommandTests: XCTestCase {

    private static let context = AdapterContext(baseUrl: "baseUrl.com/api")
    private let commandFactory = PostAdapterCommandFactory(context: context)

    func test_getUserDetails() {
        let client = HTTPClientMock.inspecting { request in
            XCTAssertEqual("GET", request.httpMethod)
            XCTAssertEqual("baseUrl.com/api/users/1?", request.url?.absoluteString)
        }
        let post = Post(userId: 1, id: 1, title: "", body: "")
        let command = commandFactory.getUserDetails(post: post)
        command.perform(in: client, dispatcher: SyncDispatcher()) { _ in }
    }
}
