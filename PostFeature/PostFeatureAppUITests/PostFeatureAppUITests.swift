import XCTest
import Adapter

@testable import PostFeature

final class PostFeatureAppUITests: PostFeatureAppUIBaseTests {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func test_list_success_user_comment_success() {
        givenTheAppLaunch()
        givenAPIRetursPosts()

        XCTAssertTrue(app.navigationBars["List of Posts"].exists)

        let cell = app.tables.cells.element(boundBy: 0)

        XCTAssertTrue(cell.waitForExistence(timeout: 2))

        XCTAssertTrue(cell.staticTexts[AccessibilityIds.Post.title].exists)
        XCTAssertTrue(cell.staticTexts[AccessibilityIds.Post.subtitle].exists)

        whenITapOnFirstCell()

        andAPIRetursUser()
        andAPIRetursComments()

        XCTAssertTrue(app.navigationBars["Details of Post"].exists)

        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.authorLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.authorValue].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.emailLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.emailValue].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.numberOfComments].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.body].exists)
    }

    func test_list_success_user_success_comment_failure() {
        givenTheAppLaunch()
        givenAPIRetursPosts()

        XCTAssertTrue(app.navigationBars["List of Posts"].exists)

        andAPIRetursUser()
        andAPIFailsComments()

        whenITapOnFirstCell()

        XCTAssertTrue(app.navigationBars["Details of Post"].exists)

        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.authorLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.authorValue].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.emailLabel].exists)
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.emailValue].exists)

        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.numberOfComments].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts[AccessibilityIds.Details.body].exists)

        XCTAssertFalse(app.alerts.firstMatch.exists)
    }

    func test_list_success_user_failure() {
        givenTheAppLaunch()
        givenAPIRetursPosts()

        XCTAssertTrue(app.navigationBars["List of Posts"].exists)

        andAPIRetursFailUser()
        whenITapOnFirstCell()

        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 2))
    }
}
