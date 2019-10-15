import UIKit
import Networking
import Adapter

class ViewController: UIViewController {
    #if DEBUG
    let client = HTTPClient(executor: HTTPClientDebugExecutor(wrapping: HTTPClientExecutor()))
    #else
    let client = HTTPClient(executor: HTTPClientExecutor())
    #endif

    var adapter: PostAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.adapter = PostAdapterImpl(client: client)
        
//        let request = HTTPRequest.get(url: "https://postman-echo.com/get")
//        client.request(request) { result in
//            print(result)
//        }
        adapter?.getPosts(completion: { (result) in
            print(result)
        })

    }


}
