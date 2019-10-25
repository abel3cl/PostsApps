import XCTest
import Core
@testable import Adapter

final class PostMapperTests: XCTestCase {

    func test_valid_json_map_succeeds() {
        do {
            let data = JsonUtils.load(file: "posts_valid")
            let response = try JSONDecoder().decode([PostResponse].self, from: data)

            guard let postResponse = response.first else {
                XCTFail("PostResponse was expected")
                return
            }
            let post = Post(withResponse: postResponse)

            XCTAssertEqual(post.userId, 1)
            XCTAssertEqual(post.id, 1)
            XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(post.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
