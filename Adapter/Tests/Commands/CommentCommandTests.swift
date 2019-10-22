import XCTest
import Core
@testable import Adapter

final class CommentCommandTests: XCTestCase {

    private static let context = AdapterContext(baseUrl: "baseUrl.com/api")
    private let commandFactory = PostAdapterCommandFactory(context: context)

    func test() {
        let client = HTTPClientMock.inspecting { request in
            XCTAssertEqual("GET", request.httpMethod)
            XCTAssertEqual("baseUrl.com/api/comments?postId=1", request.url?.absoluteString)
        }

        let post = Post(userId: 1, id: 1, title: "", body: "")
        let command = commandFactory.getComments(post: post)
        command.perform(in: client, dispatcher: SyncDispatcher()) { _ in }
    }


}
