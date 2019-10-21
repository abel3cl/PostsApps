import Core
import Adapter

protocol PostsPresenterProtocol {
    func viewDidLoad()
    func attachView(_ view: PostsListView)
    func numberOfRows() -> Int
    func set(cell: PostCell, at row: Int)
    func didSelect(at row: Int)
    func refresh()
}

final class PostsPresenter {
    weak var view: PostsListView?
    var posts: [Post] = []

    let coordinator: PostCoordinator
    let storage: AnyStorage<Post>
    let adapter: PostAdapterList
    let localizer: PostLocalizer

    init(coordinator: PostCoordinator,
         storage: AnyStorage<Post>,
         adapter: PostAdapterList,
         localizer: PostLocalizer = PostLocalizer()) {
        self.coordinator = coordinator
        self.storage = storage
        self.adapter = adapter
        self.localizer = localizer
    }

    private func handleResult(result: Result<[Post], AdapterError>) {
        view?.isLoading(false)
        switch result {
        case .success(let posts):
            self.posts = posts
            storage.save(models: posts)
            view?.reloadData()
        case .failure(.noConection):
            let persisted = loadFromStorage()
            self.posts = persisted.posts
            if let date = persisted.date {
                let df = DateFormatter()
                df.dateStyle = .medium
                view?.offlineLabel(title: df.string(from: date))
                view?.offlineLabel(isHidden: false)
            }
        case .failure:
            view?.showError()
            break
        }
    }

    private func loadFromStorage() -> (posts: [Post], date: Date?) {
        switch storage.get() {
        case .success(let posts, let date):
            return (posts, date)
        case .failure(let error):
            return ([], nil)
        }
    }
}

extension PostsPresenter: PostsPresenterProtocol {

    func attachView(_ view: PostsListView) {
        self.view = view
    }
    func viewDidLoad() {
        view?.set(title: localizer.localize(key: .title))
        view?.offlineLabel(title: "")
        view?.offlineLabel(isHidden: true)
        adapter.getPosts(completion: handleResult)
    }
    func numberOfRows() -> Int {
        return posts.count
    }
    func set(cell: PostCell, at row: Int) {
        let post = posts[row]
        cell.set(title: post.title)
        cell.set(subtitle: "\(post.id)")
    }
    func didSelect(at row: Int) {
        let post = posts[row]
        coordinator.toDetails(post: post)
    }
    func refresh() {
        adapter.getPosts(completion: handleResult)
    }
}
