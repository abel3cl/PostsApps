import Core
import Networking

public protocol PostAdapterUser {
    func getUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void)
}
public struct PostAdapterUserImpl: PostAdapterUser {
    let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }

    public func getUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        
    }

}
