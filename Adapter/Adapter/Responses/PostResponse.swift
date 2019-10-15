import Foundation

struct PostsResponse {
    let posts: [PostResponse]
}
extension PostsResponse: Codable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        posts = try container.decode([PostResponse].self)
    }
}
struct PostResponse {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension PostResponse: Codable {}
