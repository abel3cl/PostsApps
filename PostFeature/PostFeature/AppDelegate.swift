import UIKit
import Networking
import PostFeature

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let manager = PostManager(client: HTTPClient(executor: HTTPClientExecutor()))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = manager.start()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}

