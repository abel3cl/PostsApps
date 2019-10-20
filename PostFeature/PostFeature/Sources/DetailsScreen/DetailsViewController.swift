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

    func reloadData()
    func showError()
}

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var authorTitleLabel: UILabel!
    @IBOutlet private weak var authorValueLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailValueLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    let presenter: DetailsPresenterProtocol

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
    func reloadData() {

    }
    
    func showError() {

    }
}
