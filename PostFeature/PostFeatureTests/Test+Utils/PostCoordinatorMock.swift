import UIKit
import Core
@testable import PostFeature

final class PostCoordinatorMock: PostCoordinator {
    var toDetailsPost: Post?
    var started: Bool = false
    var backCount: Int = 0

    var nav: UINavigationController

    init(nav: UINavigationController) {
        self.nav = nav
    }

    func toDetails(post: Post) {
        self.toDetailsPost = post
    }
    func start() {
        started = true
    }
    func back() {
        backCount += 1
    }


}
