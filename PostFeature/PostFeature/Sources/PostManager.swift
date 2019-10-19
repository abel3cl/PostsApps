import UIKit
import Adapter

public struct PostManager {
    let coordinator: PostCoordinator
    public init(nav: UINavigationController, adapter: PostAdapter) {
        let factory = PostPresenterFactory(postAdapter: adapter)
        coordinator = PostCoordinator(nav: nav, presenterFactory: factory)
    }

    public func start() {
        return coordinator.start()
    }
}
