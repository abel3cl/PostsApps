import Networking

enum JSONError: Error {
    case invalidJson
}
struct HTTPCommand<Decode, Map> where Decode: Decodable {
    let request: HTTPRequest
    let decode: Decode.Type
    let map: (Decode) -> Map

    func perform(in client: HTTPClient,
                 dispatcher: Dispatcher,
                 completion: @escaping (Result<Map, AdapterError>) -> Void) {

        let work: (@escaping (Result<Map, AdapterError>) -> Void) -> Void = { callback in
            client.request(self.request) { result in
                let aResult = result
                    .map(self.toData)
                    .flatMap(self.toJson)
                    .flatMap(self.toMap)
                    .mapError(self.transformError)
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

    func transformError(originalError: Error) -> AdapterError {
        if let urlError = originalError as? URLError,
            urlError.code == URLError.Code.cannotConnectToHost {
            return .noConection
        }
        return .original(error: originalError)
    }

}

