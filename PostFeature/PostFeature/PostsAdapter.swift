import Core
import Networking
import Adapter

protocol PostsAdapter {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
struct PostsInteractor {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
}
extension PostsInteractor: PostsAdapter {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        PostAdapterImpl(client: client).getPosts(completion: completion)
    }
}
