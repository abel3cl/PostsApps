import Core

extension User {
    init(withResponse response: UserResponse) {
        self.init(id: response.id,
                  name: response.name,
                  username: response.username,
                  email: response.email,
                  address: .init(withResponse: response.address),
                  phone: response.phone,
                  website: response.website,
                  company: .init(withResponse: response.company))
    }
}


extension User.Address {
    init(withResponse response: UserResponse.AddressResponse) {
        self.init(street: response.street,
                  suite: response.suite,
                  city: response.city,
                  zipcode: response.zipcode,
                  geo: .init(withResponse: response.geo))
    }
}


extension User.Address.Geo {
    init(withResponse response: UserResponse.AddressResponse.GeoResponse) {
        self.init(latitude: response.latitude,
            longitude: response.longitude)
    }
}
extension User.Company {
    init(withResponse response: UserResponse.CompanyResponse) {
        self.init(name: response.name,
                  catchPhrase: response.catchPhrase,
                  businessServices: response.businessServices)
    }
}
