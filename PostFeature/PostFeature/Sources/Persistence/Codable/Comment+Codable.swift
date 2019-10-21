import Core

extension Comment: Codable {
    enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body

    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let postId = try container.decode(Int.self, forKey: .postId)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let email = try container.decode(String.self, forKey: .email)
        let body = try container.decode(String.self, forKey: .body)
        self.init(postId: postId, id: id, name: name, email: email, body: body)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(body, forKey: .body)
    }
}
