
import XCTest
@testable import Adapter

final class CommentResponseTests: XCTestCase {

    func test_valid_json_decode_succeeds() {
        do {
            let data = JsonUtils.load(file: "comments_valid")
            let response = try JSONDecoder().decode([CommentResponse].self, from: data)

            XCTAssertEqual(response.count, 2)
            XCTAssertEqual(response.first?.postId, 2)
            XCTAssertEqual(response.first?.id, 6)
            XCTAssertEqual(response.first?.name, "et fugit eligendi deleniti quidem qui sint nihil autem")
            XCTAssertEqual(response.first?.email, "Presley.Mueller@myrl.com")
            XCTAssertEqual(response.first?.body, "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus fugiat dicta\nvoluptatem rerum ut voluptate autem\nvoluptatem repellendus aspernatur dolorem in")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_invalid_json_decode_fails() {
        let data = JsonUtils.load(file: "comments_invalid")
        XCTAssertThrowsError(try JSONDecoder().decode([CommentResponse].self, from: data))
    }
}
