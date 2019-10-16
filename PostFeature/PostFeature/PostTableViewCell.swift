import UIKit

protocol PostCell {
    func set(title: String)
    func set(subtitle: String)
}

final class PostTableViewCell: UITableViewCell {}

extension PostTableViewCell: PostCell {
    func set(title: String) {
        textLabel?.text = title
    }
    func set(subtitle: String) {
        detailTextLabel?.text = subtitle
    }
}
