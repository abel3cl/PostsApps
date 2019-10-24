import Foundation

public struct LaunchArgument {
    public typealias Name = String
}

public protocol LaunchArgumentExecutable {

    /// Unprocessed list of launch arguments
    var rawLaunchArguments: [String] { get }

    /// List of launch arguments, mapped to `LaunchOption.Name`
    var launchArguments: [LaunchArgument.Name] { get }


    /// Determines if the argument list contains the desired key.
    ///
    /// ```
    /// // Example
    /// extension LaunchOption.Name {
    ///   static let uiTest = "-uiTest"
    /// }
    /// if wasLaunched(with: .uiTests) { ... }
    /// ```
    ///
    /// - Parameter key: Desired key. Best when extended `LaunchOption.Name` and declare a static variable
    /// - Returns: Boolean value determining if the key is present.
    func wasLaunched(with key: LaunchArgument.Name) -> Bool
}

extension LaunchArgumentExecutable {

    public var rawLaunchArguments: [String] {
        return ProcessInfo.processInfo.arguments
    }

    public var launchArguments: [LaunchArgument.Name] {
        return rawLaunchArguments.lazy.compactMap { LaunchArgument.Name($0) }
    }

    public func wasLaunched(with key: LaunchArgument.Name) -> Bool {
        return launchArguments.wasLaunched(with: key)
    }
}

extension Array where Element == LaunchArgument.Name {
    public func wasLaunched(with key: LaunchArgument.Name) -> Bool {
        return contains(where: { $0 == key })
    }
}
