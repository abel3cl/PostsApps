import Foundation

public protocol Dispatcher {
    func dispatch(_ work: @escaping () -> Void)
}

public struct AsyncDispatcher: Dispatcher {
    public init() {}
    public func dispatch(_ work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }
}
