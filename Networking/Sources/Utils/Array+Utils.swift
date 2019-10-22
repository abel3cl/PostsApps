import Foundation

extension Array {

    /// Returns a newly array with newElements added after existing elements
    /// - Parameter newElements: elements to be appended
    /// - returns: Array with appended elements
    public func appending(_ newElements: [Element]) -> [Element] {
        var result = self
        result.append(contentsOf: newElements)
        return result
    }
}
