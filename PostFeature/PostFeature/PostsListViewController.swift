import Core
import UIKit

protocol PostsListView: AnyObject {
    func reloadData()
    func showError()
}

final class PostsListViewController: UIViewController {

    var tableView: UITableView?

    let presenter: PostsPresenterProtocol

    init(presenter: PostsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: String(describing: PostsListViewController.self), bundle: Bundle(for: PostsListViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self)
        self.tableView = tableView
        view.addSubviewFillingParent(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attachView(self)
        presenter.viewDidLoad()
    }
}

extension PostsListViewController: PostsListView {
    func reloadData() {
        tableView?.reloadData()
    }
    func showError() {

    }
}

extension PostsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeue()
        presenter.set(cell: cell, at: indexPath.row)
        return cell
    }
}

extension PostsListViewController: UITableViewDelegate {

}
