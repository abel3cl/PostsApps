import Foundation

struct CommentResponse {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension CommentResponse: Codable {}
