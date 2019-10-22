import Core
import Networking

public protocol PostAdapterUser {
    func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void)
}

public struct PostAdapterUserImpl: PostAdapterUser {
    let commmandFactory: PostAdapterCommandFactory
    let client: HTTPClientProtocol

    public init(context: AdapterContext, client: HTTPClientProtocol) {
        self.commmandFactory = PostAdapterCommandFactory(context: context)
        self.client = client
    }

    public func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void) {
        let command = commmandFactory.getUserDetails(post: post)

        command.perform(in: client,
                        dispatcher: AsyncDispatcher(),
                        completion: completion)
    }

}
