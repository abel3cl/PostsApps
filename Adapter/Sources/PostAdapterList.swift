import Core
import Networking

public protocol PostAdapterList {
    func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void)
}

public struct PostAdapterListImpl: PostAdapterList {
    let commmandFactory: PostAdapterCommandFactory
    let client: HTTPClientProtocol

    public init(context: AdapterContext, client: HTTPClientProtocol) {
        self.commmandFactory = PostAdapterCommandFactory(context: context)
        self.client = client
    }

    public func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void) {
        let command = commmandFactory.getPost()

        command.perform(in: client,
                        dispatcher: AsyncDispatcher(),
                        completion: completion)
    }
}
