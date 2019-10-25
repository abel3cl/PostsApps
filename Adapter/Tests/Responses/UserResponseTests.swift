import XCTest
@testable import Adapter

final class UserResponseTests: XCTestCase {

    func test_valid_json_decode_succeeds() {
        do {
            let data = JsonUtils.load(file: "user_valid")
            let response = try JSONDecoder().decode(UserResponse.self, from: data)

            XCTAssertEqual(response.id, 1)
            XCTAssertEqual(response.name, "Leanne Graham")
            XCTAssertEqual(response.username, "Bret")
            XCTAssertEqual(response.email, "Sincere@april.biz")
            XCTAssertEqual(response.address.street, "Kulas Light")
            XCTAssertEqual(response.address.suite, "Apt. 556")
            XCTAssertEqual(response.address.city, "Gwenborough")
            XCTAssertEqual(response.address.zipcode, "92998-3874")
            XCTAssertEqual(response.address.geo.latitude, "-37.3159")
            XCTAssertEqual(response.address.geo.longitude, "81.1496")
            XCTAssertEqual(response.phone, "1-770-736-8031 x56442")
            XCTAssertEqual(response.website, "hildegard.org")
            XCTAssertEqual(response.company.name, "Romaguera-Crona")
            XCTAssertEqual(response.company.catchPhrase, "Multi-layered client-server neural-net")
            XCTAssertEqual(response.company.businessServices, "harness real-time e-markets")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_invalid_json_decode_fails() {
        let data = JsonUtils.load(file: "user_invalid")
        XCTAssertThrowsError(try JSONDecoder().decode(UserResponse.self, from: data))
    }
}
