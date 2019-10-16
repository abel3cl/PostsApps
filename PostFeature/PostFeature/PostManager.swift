import UIKit
import Networking

public struct PostManager {
    let coordinator: PostCoordinator
    public init(client: HTTPClient) {
        coordinator = PostCoordinator(postAdapter: PostsInteractor(client: client))
    }

    public func start() -> UIViewController {
        return coordinator.start()
    }
}
