import UIKit

protocol PostCell {
    func set(title: String)
    func set(subtitle: String)
    func set(accessoryType: UITableViewCell.AccessoryType)
}

final class PostTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0

        textLabel?.accessibilityIdentifier = AccessibilityIds.Post.title
        detailTextLabel?.accessibilityIdentifier = AccessibilityIds.Post.subtitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PostTableViewCell: PostCell {
    func set(title: String) {
        textLabel?.text = title
    }
    func set(subtitle: String) {
        detailTextLabel?.text = subtitle
    }
    func set(accessoryType: UITableViewCell.AccessoryType) {
        self.accessoryType = accessoryType
    }
}
