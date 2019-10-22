import UIKit
import Networking
import Adapter
import PostFeature

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let adapter: PostAdapter = PostAdapterImpl(context: .init(baseUrl: "https://jsonplaceholder.typicode.com"),
                              client: .init(executor: HTTPClientExecutor()))
    var postManager: PostManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let navigationController = UINavigationController()
        window.rootViewController = navigationController

        initManagers(navigation: navigationController)

        postManager?.start()
        window.makeKeyAndVisible()

        return true
    }

    private func initManagers(navigation: UINavigationController) {
        postManager = PostManager(nav: navigation, adapter: adapter)
    }

}
