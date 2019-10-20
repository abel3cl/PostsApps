import Core
import Networking

public protocol PostAdapterList {
    func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void)
}
struct PostAdapterListImpl: PostAdapterList {
    let context: AdapterContext
    let client: HTTPClient

    public init(context: AdapterContext, client: HTTPClient) {
        self.context = context
        self.client = client
    }

    public func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void) {

        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.Posts.path])

        HTTPCommand(request: request,
                    decode: [PostResponse].self,
                    map: { return $0.map(Post.init) })
        .perform(in: client,
                 dispatcher: AsyncDispatcher(),
                 completion: completion)
    }
}
