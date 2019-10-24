import XCTest
import Core
import Adapter
@testable import PostFeature

final class DetailsPresenterTests: XCTestCase {

    private var navigationController: UIMockNavigationController!
    private var coordinator: PostCoordinatorMock!
    private var storage: AnyStorage<Post>!
    private var commentsAdapter: PostAdapterCommentMock!
    private var userAdapter: PostAdapterUserMock!
    private var presenter: DetailsPresenter!
    private var view: DetailsViewMock!

    override func setUp() {
        navigationController = UIMockNavigationController()
        coordinator = PostCoordinatorMock(nav: navigationController)
        set()
    }

    private func set(commentsResponse: () -> Result<[Comment], AdapterError> = { .success([]) },
                     user: () -> User = { return User(id: 1, name: "name", username: "username", email: "email@mail.com",
                                                      address: .init(street: "street", suite: "suite", city: "city", zipcode: "zipcode",
                                                                     geo: .init(latitude: "11", longitude: "22")), phone: "phone", website: "website",
                                                                                                                   company: .init(name: "name", catchPhrase: "catchPhrase", businessServices: "businessServices")) },
                     userResponse: (_ user: User) -> Result<User, AdapterError> = { user in return .success(user) }) {

        commentsAdapter = PostAdapterCommentMock()
        userAdapter = PostAdapterUserMock()
        userAdapter.getUserDetails = userResponse(user())
        commentsAdapter.getComments = commentsResponse()
        let post = Post(userId: user().id, id: 10, title: "this is a title", body: "This is a body")
        presenter = DetailsPresenter(post: post, coordinator: coordinator, commentAdapter: commentsAdapter, userAdapter: userAdapter)
        view = DetailsViewMock()
        presenter.attachView(view)
    }

    func test_viewDidLoad_success_setsView() {
        set(commentsResponse: {
            return .success([Comment(postId: 1, id: 1, name: "name", email: "email", body: "body"),
                             Comment(postId: 2, id: 2, name: "name", email: "email", body: "body")])
        })
        presenter.viewDidLoad()

        XCTAssertEqual(view.viewTitle, "Details of Post")
        XCTAssertEqual(view.authorTitle, "Author:")
        XCTAssertEqual(view.authorValue, "name")
        XCTAssertEqual(view.emailTitle, "Email:")
        XCTAssertEqual(view.emailValue, "email@mail.com")
        XCTAssertEqual(view.numberOfComments, "This post has 2 comments")
        XCTAssertEqual(view.numberOfCommentsIsHidden, false)
        XCTAssertEqual(view.body, "This is a body")
    }

    func test_viewDidLoad_1_comment_setsView() {
        set(commentsResponse: {
            return .success([Comment(postId: 1, id: 1, name: "name", email: "email", body: "body")])
        })
        presenter.viewDidLoad()

        XCTAssertEqual(view.viewTitle, "Details of Post")
        XCTAssertEqual(view.authorTitle, "Author:")
        XCTAssertEqual(view.authorValue, "name")
        XCTAssertEqual(view.emailTitle, "Email:")
        XCTAssertEqual(view.emailValue, "email@mail.com")
        XCTAssertEqual(view.numberOfComments, "This post has 1 comment")
        XCTAssertEqual(view.numberOfCommentsIsHidden, false)
        XCTAssertEqual(view.body, "This is a body")
    }

    func test_viewDidLoad_userSuccess_commentsFailure_setsView() {
        set(commentsResponse: {
            return .failure(AdapterError.noConection)
        })
        presenter.viewDidLoad()

        XCTAssertEqual(view.viewTitle, "Details of Post")
        XCTAssertEqual(view.authorTitle, "Author:")
        XCTAssertEqual(view.authorValue, "name")
        XCTAssertEqual(view.emailTitle, "Email:")
        XCTAssertEqual(view.emailValue, "email@mail.com")
        XCTAssertEqual(view.numberOfComments, "You lost your connection. Try again later.")
        XCTAssertEqual(view.numberOfCommentsIsHidden, false)
        XCTAssertEqual(view.body, "This is a body")
    }

    func test_viewDidLoad_userFailure_commentsSuccess_setsView() {
        set(commentsResponse: { return .success([Comment(postId: 1, id: 1, name: "name", email: "email", body: "body")]) },
            userResponse: { _ in return .failure(AdapterError.noConection) })

        presenter.viewDidLoad()

        XCTAssertEqual(view.viewTitle, "Details of Post")
        XCTAssertEqual(view.authorTitle, "Author:")
        XCTAssertEqual(view.authorValue, "Loading...")
        XCTAssertEqual(view.emailTitle, "Email:")
        XCTAssertEqual(view.emailValue, "Loading...")
        XCTAssertNotNil(view.error)
        XCTAssertEqual(view.numberOfComments, "This post has 1 comment")
        XCTAssertEqual(view.numberOfCommentsIsHidden, false)
        XCTAssertEqual(view.body, "This is a body")
    }
}

private class DetailsViewMock: DetailsView {
    var loading: Bool?
    var viewTitle: String?
    var authorTitle: String?
    var authorValue: String?
    var emailTitle: String?
    var emailValue: String?
    var numberOfComments: String?
    var numberOfCommentsIsHidden: Bool?
    var body: String?
    var error: Error?

    func isLoading(_ loading: Bool) { self.loading = loading }
    func set(title: String) { viewTitle = title }
    func set(authorTitle: String) { self.authorTitle = authorTitle }
    func set(authorValue: String) { self.authorValue = authorValue }
    func set(emailTitle: String) { self.emailTitle = emailTitle }
    func set(emailValue: String) { self.emailValue = emailValue }
    func set(numberOfComments: String) { self.numberOfComments = numberOfComments }
    func set(numberOfCommentsIsHidden: Bool) { self.numberOfCommentsIsHidden = numberOfCommentsIsHidden }
    func set(body: String) { self.body = body }
    func showError(_ error: Error) { self.error = error }
}
