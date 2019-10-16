import Foundation

public struct Comment {
    public let postId: Post.ID
    public let id: Int
    public let name: String
    public let email: String
    public let body: String

    public init(postId: Int,
                id: Int,
                name: String,
                email: String,
                body: String) {
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}

extension Comment: Identifiable {}
