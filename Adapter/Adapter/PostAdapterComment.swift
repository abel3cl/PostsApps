import Core
import Networking

public protocol PostAdapterComment {
    func getComments(post: Post, completion: @escaping (Result<Comment, Error>) -> Void)
}

public struct PostAdapterCommentImpl: PostAdapterComment {
    let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func getComments(post: Post, completion: @escaping (Result<Comment, Error>) -> Void) {

    }

}
