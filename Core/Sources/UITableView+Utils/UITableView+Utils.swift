import Foundation
import UIKit

public extension UITableView {
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        register(Cell.self, forCellReuseIdentifier: Cell.id)
    }
    func dequeue<Cell: UITableViewCell>() -> Cell {
        if let cell = dequeueReusableCell(withIdentifier: Cell.id) as? Cell {
            return cell
        } else {
            fatalError("\(Cell.self) can't be dequeued")
        }

    }
}

public protocol Reusable {
    static var id: String { get }
}
public extension Reusable {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
