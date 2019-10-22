import Foundation

public struct Post {
    public let userId: User.ID
    public let id: Int
    public let title: String
    public let body: String

    public init(userId: Int,
                id: Int,
                title: String,
                body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

extension Post: Identifiable {}
