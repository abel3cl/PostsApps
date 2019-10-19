import UIKit
import Core

struct PostCoordinator: Coordinator {
    let nav: UINavigationController
    let presenterFactory: PostPresenterFactory

    init(nav: UINavigationController,
         presenterFactory: PostPresenterFactory) {
        self.nav = nav
        self.presenterFactory = presenterFactory
    }
    func start() {
        let presenter = presenterFactory.getPostsPresenter(coordinator: self)
        let postsViewController = PostsListViewController(presenter: presenter)
        nav.setViewControllers([postsViewController], animated: true)
    }
    func toDetails(post: Post) {
        let presenter = presenterFactory.getDetailsPresenter(post:post, coordinator: self)
        let detailsViewController = DetailsViewController(presenter: presenter)
        nav.pushViewController(detailsViewController, animated: true)
    }
    func back() {
        nav.popViewController(animated: true)
    }
}
