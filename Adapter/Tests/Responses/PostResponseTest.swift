import XCTest
@testable import Adapter

final class PostResponseTest: XCTestCase {

    func test_valid_json_decode_succeeds() {
        do {
        let data = JsonUtils.load(file: "posts_valid")
        let response = try JSONDecoder().decode([PostResponse].self, from: data)

        XCTAssertEqual(response.count, 3)
        XCTAssertEqual(response.first?.userId, 1)
        XCTAssertEqual(response.first?.id, 1)
        XCTAssertEqual(response.first?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(response.first?.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_invalid_json_decode_fails() {
        let data = JsonUtils.load(file: "posts_invalid")
        XCTAssertThrowsError(try JSONDecoder().decode([PostResponse].self, from: data))
    }
}
