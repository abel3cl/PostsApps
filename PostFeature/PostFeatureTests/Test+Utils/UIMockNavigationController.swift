import UIKit

final class UIMockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var presentViewController: UIViewController?
    var dimissedCount = 0

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewController = viewControllerToPresent
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dimissedCount += 1
    }

}
