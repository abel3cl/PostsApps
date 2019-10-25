import XCTest
@testable import Core

final class PersistenceTests: XCTestCase {

    private var storage: AnyStorage<User>!

    override func setUp() {
        storage = AnyStorage(MemoryStorage<User>(), dispatcher: SyncDispatcher())
    }

    func test_get_empty_returnsFailureNotFound() {
        let result = storage.get()
        guard case .failure(.notFound) = result else {
            XCTFail("notFound error expected instead \(result)")
            return
        }
    }

    func test_save_empty_returnsSuccessEmpty() {
        storage.save(models: [])

        let result = storage.get()
        guard case .success(let models, let date) = result else {
            XCTFail("Success expected instead \(result)")
            return
        }

        XCTAssertEqual(models.count, 0)
        XCTAssertNil(models.first)
        XCTAssertNotNil(date)
    }

    func test_save_user_returnsSuccessUser() {
        let user = User(name: "Abel")
        storage.save(models: [user])

        let result = storage.get()
        guard case .success(let models, let date) = result else {
            XCTFail("Success expected instead \(result)")
            return
        }

        XCTAssertEqual(models.count, 1)
        XCTAssertEqual(models.first?.name, user.name)
        XCTAssertNotNil(date)
    }

    func test_save_users_returnsSuccessUsers() {
        let user1 = User(name: "Abel")
        storage.save(models: [user1])

        let result1 = storage.get()
        guard case .success(let models1, let date1) = result1 else {
            XCTFail("Success expected instead \(result1)")
            return
        }

        XCTAssertEqual(models1.count, 1)
        XCTAssertEqual(models1.first?.name, user1.name)
        XCTAssertNotNil(date1)

        let user2 = User(name: "Travis")
        storage.save(models: [user2])

        let result2 = storage.get()
        guard case .success(let models2, let date2) = result2 else {
            XCTFail("Success expected instead \(result2)")
            return
        }

        XCTAssertEqual(models2.count, 2)
        XCTAssertEqual(models2.first?.name, user1.name)
        XCTAssertEqual(models2.last?.name, user2.name)
        XCTAssertTrue(date1 < date2)
    }
}

private struct User: Codable {
    let name: String
}

private struct SyncDispatcher: Dispatcher {
    func dispatch(_ work: () -> Void) {
        work()
    }
}
