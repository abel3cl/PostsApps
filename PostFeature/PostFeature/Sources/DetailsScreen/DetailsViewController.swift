import UIKit

protocol DetailsView: AnyObject {
    func isLoading(_ loading: Bool)
    func set(title: String)

    func set(authorTitle: String)
    func set(authorValue: String)
    func set(emailTitle: String)
    func set(emailValue: String)

    func set(numberOfComments: String)
    func set(numberOfCommentsIsHidden: Bool)

    func set(body: String)

    func showError(_ error: Error)
}

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var authorTitleLabel: UILabel!
    @IBOutlet private weak var authorValueLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailValueLabel: UILabel!
    @IBOutlet private weak var numberOfCommentsLabel: UILabel!
    @IBOutlet private weak var bodyTextView: UITextView!

    private let presenter: DetailsPresenterProtocol

    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: DetailsViewController.self), bundle: Bundle(for: DetailsViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)
        presenter.viewDidLoad()
        setAccessibility()
    }

    private func setAccessibility() {
        authorTitleLabel.accessibilityIdentifier = AccessibilityIds.Details.authorLabel
        authorValueLabel.accessibilityIdentifier = AccessibilityIds.Details.authorValue
        emailTitleLabel.accessibilityIdentifier = AccessibilityIds.Details.emailLabel
        emailValueLabel.accessibilityIdentifier = AccessibilityIds.Details.emailValue
        numberOfCommentsLabel.accessibilityIdentifier = AccessibilityIds.Details.numberOfComments
        bodyTextView.isAccessibilityElement = true
        bodyTextView.accessibilityIdentifier = AccessibilityIds.Details.body
    }
}

extension DetailsViewController: DetailsView {
    func isLoading(_ loading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = loading
    }
    func set(title: String) {
        navigationItem.title = title
    }

    func set(authorTitle: String) {
        authorTitleLabel.text = authorTitle
    }
    func set(authorValue: String) {
        authorValueLabel.text = authorValue
    }
    func set(emailTitle: String) {
        emailTitleLabel.text = emailTitle
    }
    func set(emailValue: String) {
        emailValueLabel.text = emailValue
    }
    func set(numberOfComments: String) {
        numberOfCommentsLabel.text = numberOfComments
    }
    func set(numberOfCommentsIsHidden: Bool) {
        numberOfCommentsLabel.isHidden = numberOfCommentsIsHidden
    }
    func set(body: String) {
        bodyTextView.text = body
    }
    func showError(_ error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
