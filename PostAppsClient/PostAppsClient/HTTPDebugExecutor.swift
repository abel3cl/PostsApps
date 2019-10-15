import Networking

struct HTTPClientDebugExecutor: HTTPClientExecutorProtocol {
    let wrapping: HTTPClientExecutorProtocol
    func resume(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print("REQUESTING:")
        print(" METHOD: \(request.httpMethod ?? "")")
        print(" URL: \(request.url?.absoluteString ?? "")")
        print(" Headers:")

        print(request.allHTTPHeaderFields?.reduce("") { (result, dict) -> String in
            return result.appending(" \(dict.key): \(dict.value)").appending("\n")
        } ?? "")
        print(" Body:")
        if let body = request.httpBody {
            print(String(decoding: body, as: UTF8.self))
        }


        wrapping.resume(request: request) { (data, response, error) in
            print("RESPONSE:")
            if let response = response as? HTTPURLResponse {
                print(" Status code: \(response.statusCode)")
                print(" Headers:")

                print(response.allHeaderFields.reduce("") { (result, dict) -> String in
                    return result.appending(" \(dict.key): \(dict.value)").appending("\n")
                })

                print(" Body:")
                if let data = data {
                    print(String(decoding: data, as: UTF8.self))
                }

                if let error = error {
                    print("⚠️")
                    print(error)
                    print(error.localizedDescription)
                } else {
                    print("✅")
                }
            }


            completion(data, response, error)
        }
    }
}
