import Foundation
import Networking

public struct PostAdapter {
    public var post: PostAdapterList
    public var user: PostAdapterUser
    public var comment: PostAdapterComment

    public init(client: HTTPClient) {
        post = PostAdapterListImpl(client: client)
        user = PostAdapterUserImpl(client: client)
        comment = PostAdapterCommentImpl(client: client)
    }
}


