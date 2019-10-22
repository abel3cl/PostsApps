import XCTest
import Core
@testable import Adapter

final class CommentMapperTests: XCTestCase {
    
    func test_valid_json_map_succeeds() {
        do {
            
            let data = JsonUtils.load(file: "comments_valid")
            let response = try JSONDecoder().decode([CommentResponse].self, from: data)

            guard let commentResponse = response.first else {
                XCTFail("CommentResponse was expected")
                return
            }
            let comment = Comment(withResponse: commentResponse)
            
            XCTAssertEqual(comment.postId, 2)
            XCTAssertEqual(comment.id, 6)
            XCTAssertEqual(comment.name, "et fugit eligendi deleniti quidem qui sint nihil autem")
            XCTAssertEqual(comment.email, "Presley.Mueller@myrl.com")
            XCTAssertEqual(comment.body, "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus fugiat dicta\nvoluptatem rerum ut voluptate autem\nvoluptatem repellendus aspernatur dolorem in")

        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
