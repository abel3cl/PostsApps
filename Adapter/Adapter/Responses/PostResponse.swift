import Foundation

struct PostResponse {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension PostResponse: Codable {}
