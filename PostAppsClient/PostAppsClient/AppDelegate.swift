import UIKit
import Adapter
import PostFeature
import Networking

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    static let url = "https://jsonplaceholder.typicode.com"
    #if DEBUG
    let adapter = PostAdapterImpl(context: .init(baseUrl: url),
                              client: HTTPClient(executor: HTTPClientDebugExecutor(wrapping: HTTPClientExecutor())))
    #else
    let adapter = PostAdapterImpl(context: .init(baseUrl: url),
                              client: HTTPClient(executor: HTTPClientExecutor()))
    #endif
    var postManager: PostManager?

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        initManagers(navigation: navigationController)

        self.window = window
        window.makeKeyAndVisible()

        return true
    }

    private func initManagers(navigation: UINavigationController) {
        postManager = PostManager(nav: navigation, adapter: adapter)

        postManager?.start()
    }
}
