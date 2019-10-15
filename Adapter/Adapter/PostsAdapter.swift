import Core
import Networking

public protocol PostAdapter {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
public struct PostAdapterImpl: PostAdapter {
    let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {

        let request = HTTPRequest.get(url: "http://jsonplaceholder.typicode.com/posts")

        HTTPCommand(request: request,
                    map: { (response: PostsResponse) in
                        return response.posts.map(Post.init)
        })
        .perform(in: client,
                 dispatcher: AsyncDispatcher(),
                 completion: completion)
    }
}

extension Post {
    init(withResponse response: PostResponse) {
        self.init(userId: response.userId,
                  id: response.id,
                  title: response.title,
                  body: response.body,
                  comments: [])

    }
}
