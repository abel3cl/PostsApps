import Foundation

struct UserResponse {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressResponse
    let phone: String
    let website: String
    let company: CompanyResponse
}
extension UserResponse: Codable {}

extension UserResponse {
    struct AddressResponse {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: GeoResponse
    }
}

extension UserResponse.AddressResponse : Codable {}

extension UserResponse.AddressResponse {
    struct GeoResponse {
        let latitude: String
        let longitude: String
    }
}

extension UserResponse.AddressResponse.GeoResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

extension UserResponse {
    struct CompanyResponse {
        let name: String
        let catchPhrase: String
        let businessServices: String
    }
}

extension UserResponse.CompanyResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case businessServices = "bs"
    }
}
