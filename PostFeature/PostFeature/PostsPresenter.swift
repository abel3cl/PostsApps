import Core

protocol PostsPresenterProtocol {
    func viewDidLoad()
    func attachView(_ view: PostsListView)
    func numberOfRows() -> Int
    func set(cell: PostCell, at row: Int)
}

final class PostsPresenter {
    weak var view: PostsListView?
    var posts: [Post] = []

    let adapter: PostsAdapter

    init(adapter: PostsAdapter) {
        self.adapter = adapter
    }

    private func handleResult(result: Result<[Post], Error>) {
        switch result {
        case .success(let posts):
            self.posts = posts
            view?.reloadData()
        case .failure(let error):
            break
        }
    }
}

extension PostsPresenter: PostsPresenterProtocol {

    func attachView(_ view: PostsListView) {
        self.view = view
    }
    func viewDidLoad() {
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
}
