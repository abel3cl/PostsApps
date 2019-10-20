import Core
import Networking

public protocol PostAdapterUser {
    func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void)
}
public struct PostAdapterUserImpl: PostAdapterUser {
    let context: AdapterContext
    let client: HTTPClient

    public init(context: AdapterContext, client: HTTPClient) {
        self.context = context
        self.client = client
    }

    public func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void) {
        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.User.path, "\(post.userId)"])

        let command = HTTPCommand(request: request,
                                  decode: UserResponse.self,
                                  map: User.init)

        command.perform(in: client,
                        dispatcher: AsyncDispatcher(),
                        completion: completion)
    }

}
