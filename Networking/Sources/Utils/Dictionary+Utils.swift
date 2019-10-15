import Foundation

extension Dictionary {

    /// Returns a new dictionary result of merging both dictionaries
    /// - Parameter rhs: Keys in this dictionary take priority
    /// - Parameter lhs: Other dictionary
    /// - returns: Dictionary with both elements
    static func + (rhs: Dictionary, lhs: Dictionary?) -> Dictionary {
        guard let lhs = lhs else { return rhs }
        return rhs.merging(lhs) { key, _ in return key }
    }
}
