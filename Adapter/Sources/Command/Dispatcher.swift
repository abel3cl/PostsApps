import Foundation

protocol Dispatcher {
    func dispatch<T>(work: @escaping (_ completion:  @escaping (T) -> Void) -> Void, completion: @escaping (T) -> Void)
}

struct AsyncDispatcher: Dispatcher {
    func dispatch<T>(work: @escaping (_ completion:  @escaping (T) -> Void) -> Void, completion: @escaping (T) -> Void) {
        DispatchQueue.global().async {
            work { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
