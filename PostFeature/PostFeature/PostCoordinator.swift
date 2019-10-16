import UIKit
import Core

struct PostCoordinator: Coordinator {
    let presenterFactory: PostPresenterFactory

    init(postAdapter: PostsAdapter) {
        presenterFactory = PostPresenterFactory(postAdapter: postAdapter)
    }
    func start() -> UIViewController {
        let presenter = presenterFactory.getPostsPresenter()
        let postsViewController = PostsListViewController(presenter: presenter)
        let nav = UINavigationController(rootViewController: postsViewController)
        nav.navigationBar.backgroundColor = .white
        return nav
    }
}
