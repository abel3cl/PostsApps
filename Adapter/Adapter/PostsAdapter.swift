import Foundation
import Networking

public struct PostAdapter {
    public var post: PostAdapterList
    public var user: PostAdapterUser
    public var comment: PostAdapterComment

    public init(context: AdapterContext, client: HTTPClient) {
        post = PostAdapterListImpl(context: context, client: client)
        user = PostAdapterUserImpl(context: context, client: client)
        comment = PostAdapterCommentImpl(context: context, client: client)
    }
}

public struct AdapterContext {
    let baseUrl: String

    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}
