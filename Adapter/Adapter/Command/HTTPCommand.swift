import Networking

enum JSONError: Error {
    case invalidJson
}
struct HTTPCommand<Decode, Map> where Decode: Decodable {
    let request: HTTPRequest
    let map: (Decode) -> Map

    func perform(in client: HTTPClient,
                 dispatcher: Dispatcher,
                 completion: @escaping (Result<Map, Error>) -> Void) {

        let work: (@escaping (Result<Map, Error>) -> Void) -> Void = { callback in
            client.request(self.request) { result in
                let aResult = result
                    .map(self.toData)
                    .flatMap(self.toJson)
                    .flatMap(self.toMap)
                callback(aResult)
            }
        }
        dispatcher.dispatch(work: work,
                            completion: completion)
    }


    func toData(result: HTTPResult) -> Data? {
        return result.data
    }

    func toJson(data: Data?) -> Result<Decode, Error> {
        do {
            guard let data = data else {
                return .failure(JSONError.invalidJson)
            }
            return .success(try JSONDecoder().decode(Decode.self, from: data))
        } catch {
            return .failure(error)
        }
    }

    func toMap(decode: Decode) -> Result<Map, Error> {
        return .success(map(decode))
    }

}

