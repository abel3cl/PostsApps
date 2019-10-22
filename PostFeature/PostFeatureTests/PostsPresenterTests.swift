import XCTest
import Core
import Adapter
@testable import PostFeature

final class PostsPresenterTests: XCTestCase {

    private var navigationController: UIMockNavigationController!
    private var coordinator: PostCoordinatorMock!
    private var storage: AnyStorage<Post>!
    private var adapter: PostAdapterListMock!
    private var presenter: PostsPresenter!
    private var view: PostsListViewMock!

    override func setUp() {
        navigationController = UIMockNavigationController()
        coordinator = PostCoordinatorMock(nav: navigationController)
        set()
    }

    private func set(storageResult: () -> StorageResult<[Post], StorageError> = { .success([], Date()) },
                     response: () -> Result<[Post], AdapterError> = { .success([]) }) {
        storage = AnyStorage(MemoryStorage<Post>(mockResult: storageResult()))
        adapter = PostAdapterListMock()
        adapter.getPosts = response()
        presenter = PostsPresenter(coordinator: coordinator, storage: storage, adapter: adapter)
        view = PostsListViewMock()
        presenter.attachView(view)
    }

    func test_numberOfRows_empty_returns0() {
        XCTAssertEqual(presenter.numberOfRows(), 0)
    }

    func test_numberOfRows_filled_returnsRows() {
        let post1 = Post(userId: 1, id: 1, title: "title", body: "body")
        let post2 = Post(userId: 2, id: 2, title: "title2", body: "body2")
        set {
            .success([post1, post2])
        }
        presenter.viewDidLoad()
        XCTAssertEqual(presenter.numberOfRows(), 2)
    }

    func test_viewDidLoad_success_setsView() {
        XCTAssertEqual(view.reloadDataCount, 0)

        presenter.viewDidLoad()

        XCTAssertEqual(view.reloadDataCount, 1)
        XCTAssertEqual(view.viewTitle, "List of Posts")
        XCTAssertEqual(view.reloadDataCount, 1)
        XCTAssertEqual(view.offlineLabelTitle, "")
        XCTAssertEqual(view.offlineLabelIsHidden, true)
    }

    func test_viewDidLoad_failure_loadsFromStorage() {
        let post1 = Post(userId: 1, id: 1, title: "title", body: "body")
        let date = Date()

        set(storageResult: { .success([post1], date) },
            response: { .failure(AdapterError.noConection) })

        XCTAssertEqual(view.reloadDataCount, 0)

        presenter.viewDidLoad()

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .full

        XCTAssertEqual(view.reloadDataCount, 1)
        XCTAssertEqual(view.viewTitle, "List of Posts")
        XCTAssertEqual(view.reloadDataCount, 1)
        XCTAssertEqual(view.offlineLabelTitle, "Your data is from: \(formatter.string(from: date))")
        XCTAssertEqual(view.offlineLabelIsHidden, false)
    }

    func test_setCell_setsCell() {
        let post1 = Post(userId: 1, id: 1, title: "title", body: "body")
        set {
            .success([post1])
        }
        let cell = PostCellMock()

        presenter.viewDidLoad()
        presenter.set(cell: cell, at: 0)

        XCTAssertEqual(cell.title, "title")
        XCTAssertEqual(cell.subtitle, "1")
    }

    func test_didSelect_pushesController() {
        let post1 = Post(userId: 1, id: 1, title: "title", body: "body")
        set {
            .success([post1])
        }
        presenter.viewDidLoad()
        presenter.didSelect(at: 0)
        XCTAssertNotNil(coordinator.toDetailsPost)
    }

    func test_refresh_reloadsData() {
        presenter.refresh()

    }
}

private class PostsListViewMock: PostsListView {
    var loading: Bool?
    var viewTitle: String?
    var reloadDataCount = 0
    var offlineLabelTitle: String?
    var offlineLabelIsHidden: Bool?

    func isLoading(_ loading: Bool) { self.loading = loading }
    func set(title: String) { viewTitle = title }
    func reloadData() { reloadDataCount += 1 }
    func offlineLabel(title: String) { offlineLabelTitle = title }
    func offlineLabel(isHidden: Bool) { offlineLabelIsHidden = isHidden }
    func showError() { }
}

private class PostCellMock: PostCell {
    var title: String?
    var subtitle: String?

    func set(title: String) { self.title = title }
    func set(subtitle: String) { self.subtitle = subtitle }
}
