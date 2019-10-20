import Foundation

public protocol Localizable: AnyObject {
    associatedtype LocalizableKey
    var tableName: String { get }
    
    func localize(key: LocalizableKey) -> String
}

public extension Localizable where LocalizableKey: RawRepresentable {
    func localize(key: LocalizableKey) -> String {

        return NSLocalizedString("\(key.rawValue)", tableName: tableName, bundle: Bundle(for: Self.self), value: "**\(key.rawValue)**", comment: "")
    }

    func localizedString(key: LocalizableKey, num: Int) -> String {
        return String.localizedStringWithFormat(localize(key: key), num)
    }
}
