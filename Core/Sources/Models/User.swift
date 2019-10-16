import Foundation

public struct User {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let address: Address
    public let phone: String
    public let website: String
    public let company: Company

    public init(id: Int,
                name: String,
                username: String,
                email: String,
                address: Address,
                phone: String,
                website: String,
                company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}
extension User: Identifiable {}
extension User {
    public struct Address {
        public let street: String
        public let suite: String
        public let city: String
        public let zipcode: String
        public let geo: Geo

        public init(street: String,
                    suite: String,
                    city: String,
                    zipcode: String,
                    geo: Geo) {
            self.street = street
            self.suite = suite
            self.city = city
            self.zipcode = zipcode
            self.geo = geo
        }
    }
}

extension User.Address {
    public struct Geo {
        public let lat: String
        public let lng: String

        public init(lat: String,
                    lng: String) {
            self.lat = lat
            self.lng = lng
        }
    }
}

extension User {
    public struct Company {
        public let name: String
        public let catchPhrase: String
        public let bs: String

        public init(name: String,
                    catchPhrase: String,
                    bs: String) {
            self.name = name
            self.catchPhrase = catchPhrase
            self.bs = bs
        }
    }
}
