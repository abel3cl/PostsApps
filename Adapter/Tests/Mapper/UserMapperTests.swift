import XCTest
import Core
@testable import Adapter

final class UserMapperTests: XCTestCase {
    
    func test_valid_json_map_succeeds() {
        do {
            let data = JsonUtils.load(file: "user_valid")
            let response = try JSONDecoder().decode(UserResponse.self, from: data)

            let user = User(withResponse: response)
            
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.name, "Leanne Graham")
            XCTAssertEqual(user.username, "Bret")
            XCTAssertEqual(user.email, "Sincere@april.biz")
            XCTAssertEqual(user.address.street, "Kulas Light")
            XCTAssertEqual(user.address.suite, "Apt. 556")
            XCTAssertEqual(user.address.city, "Gwenborough")
            XCTAssertEqual(user.address.zipcode, "92998-3874")
            XCTAssertEqual(user.address.geo.latitude, "-37.3159")
            XCTAssertEqual(user.address.geo.longitude, "81.1496")
            XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
            XCTAssertEqual(user.website, "hildegard.org")
            XCTAssertEqual(user.company.name, "Romaguera-Crona")
            XCTAssertEqual(user.company.catchPhrase, "Multi-layered client-server neural-net")
            XCTAssertEqual(user.company.businessServices, "harness real-time e-markets")

            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

