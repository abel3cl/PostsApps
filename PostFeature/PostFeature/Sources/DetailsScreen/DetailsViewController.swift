import UIKit

protocol DetailsView: AnyObject {
    func set(title: String)
    func reloadData()
    func showError()
}

final class DetailsViewController: UIViewController {

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
    func set(title: String) {
        navigationItem.title = title
    }

    func reloadData() {

    }
    
    func showError() {

    }
}
