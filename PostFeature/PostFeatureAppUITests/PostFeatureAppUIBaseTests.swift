import XCTest

class PostFeatureAppUIBaseTests: XCTestCase {

    let app = XCUIApplication()
    let stubs = Stubs()

    override func setUp() {
        super.setUp()

        do {
            try stubs.setUp()
        } catch {
            XCTFail("Failed to load Stub")
        }

        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
        stubs.tearDown()
    }


}
