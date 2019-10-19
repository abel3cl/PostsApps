import Core
import Adapter

protocol DetailsPresenterProtocol {
    func viewDidLoad()
    func attachView(_ view: DetailsView)
}

final class DetailsPresenter {
    weak var view: DetailsView?
    let post: Post

    let coordinator: PostCoordinator
    let commentAdapter: PostAdapterComment
    let userAdapter: PostAdapterUser
    let localizer: DetailsLocalizer

    init(post: Post,
         coordinator: PostCoordinator,
         commentAdapter: PostAdapterComment,
         userAdapter: PostAdapterUser,
         localizer: DetailsLocalizer = DetailsLocalizer()) {
        self.post = post
        self.coordinator = coordinator
        self.commentAdapter = commentAdapter
        self.userAdapter = userAdapter
        self.localizer = localizer
    }

}

extension DetailsPresenter: DetailsPresenterProtocol {
    func viewDidLoad() {
        view?.set(title: localizer.localize(key: .title))
        userAdapter.getUserDetails(userId: post.userId) { result in
            <#code#>
        }
    }
    func attachView(_ view: DetailsView) {
        self.view = view
    }

}
