import Core

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let username = try container.decode(String.self, forKey: .username)
        let email = try container.decode(String.self, forKey: .email)
        let address = try container.decode(Address.self, forKey: .address)
        let phone = try container.decode(String.self, forKey: .phone)
        let website = try container.decode(String.self, forKey: .website)
        let company = try container.decode(Company.self, forKey: .company)

        self.init(id: id, name: name, username: username, email: email,
                  address: address, phone: phone, website: website, company: company)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)
        try container.encode(company, forKey: .company)
    }
}

extension User.Address: Codable {
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let street = try container.decode(String.self, forKey: .street)
        let suite = try container.decode(String.self, forKey: .suite)
        let city = try container.decode(String.self, forKey: .city)
        let zipcode = try container.decode(String.self, forKey: .zipcode)
        let geo = try container.decode(Geo.self, forKey: .geo)
        self.init(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(geo, forKey: .geo)
    }
}

extension User.Address.Geo: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(String.self, forKey: .latitude)
        let longitude = try container.decode(String.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension User.Company: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case businessServices
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        let businessServices = try container.decode(String.self, forKey: .businessServices)
        self.init(name: name, catchPhrase: catchPhrase, businessServices: businessServices)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(businessServices, forKey: .businessServices)
    }
}
