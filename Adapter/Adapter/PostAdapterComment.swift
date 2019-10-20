import Core
import Networking

public protocol PostAdapterComment {
    func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void)
}

public struct PostAdapterCommentImpl: PostAdapterComment {
    let context: AdapterContext
    let client: HTTPClient
    
    public init(context: AdapterContext, client: HTTPClient) {
        self.context = context
        self.client = client
    }

    public func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void) {
        let queryParams = [Constants.Comments.postId: "\(post.id)"]
        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.Comments.path],
                  queryParams: queryParams)

        let command = HTTPCommand(request: request,
                                  decode: [CommentResponse].self,
                                  map: { return $0.map(Comment.init) })

        command.perform(in: client,
                        dispatcher: AsyncDispatcher(),
                        completion: completion)
    }

}
