import UIKit
import Networking
import Adapter
import PostFeature

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
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
        let url: String

        if !wasLaunched(with: .uiTest) {
            url = "https://jsonplaceholder.typicode.com"
        } else { // UITest
            url = "http://localhost:9080"
        }
        let adapter = PostAdapterImpl(context: .init(baseUrl: url),
                                      client: HTTPClient(executor: HTTPClientExecutor()))

        postManager = PostManager(nav: navigation, adapter: adapter)
    }

}

extension AppDelegate: LaunchArgumentExecutable {}
