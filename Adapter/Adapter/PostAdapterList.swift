import Core
import Networking

public protocol PostAdapterList {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
struct PostAdapterListImpl: PostAdapterList {
    let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {

        let request = HTTPRequest.get(url: "https://jsonplaceholder.typicode.com/posts")

        HTTPCommand(request: request,
                    decode: [PostResponse].self,
                    map: { return $0.map(Post.init) })
        .perform(in: client,
                 dispatcher: AsyncDispatcher(),
                 completion: completion)
    }
}
