import Core
import Networking

public protocol PostAdapterComment {
    func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void)
}

public struct PostAdapterCommentImpl: PostAdapterComment {
    let commmandFactory: PostAdapterCommandFactory
    let client: HTTPClientProtocol

    public init(context: AdapterContext, client: HTTPClientProtocol) {
        self.commmandFactory = PostAdapterCommandFactory(context: context)
        self.client = client
    }

    public func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void) {
        let command = commmandFactory.getComments(post: post)


        command.perform(in: client,
                        dispatcher: AsyncDispatcher(),
                        completion: completion)
    }

}
