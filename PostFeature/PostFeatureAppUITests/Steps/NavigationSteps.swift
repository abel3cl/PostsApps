import XCTest
@testable import PostFeature

extension PostFeatureAppUIBaseTests {

    // MARK: Given
    func givenTheAppLaunch() {
        app.launchArguments = [LaunchArgument.Name.uiTest]
        app.launch()
    }

    func givenAPIRetursPosts() {
        stubs.setupStub(url: StubUrls.Post.get, filename: "posts_valid")
    }

    func andAPIRetursComments() {
        stubs.setupStub(url: StubUrls.Comment.get, filename: "comments_valid")
    }

    func andAPIFailsComments() {
        stubs.setupStub(url: StubUrls.Comment.get, statusCode: 500)
    }

    func andAPIRetursUser() {
        stubs.setupStub(url: StubUrls.User.get, filename: "user_valid")
    }

    // MARK: When

    func whenITapOnFirstCell() {
        let cell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 2))
        cell.tap()
    }

}
