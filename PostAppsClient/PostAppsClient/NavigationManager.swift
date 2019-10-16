import UIKit
import PostFeature

struct NavigationManager {

    func buildNavigation(on window: UIWindow) {
        window.rootViewController = PostCoordinator().start()
        window.makeKeyAndVisible()
    }
}
