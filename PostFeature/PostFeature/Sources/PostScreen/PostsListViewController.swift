import Core
import UIKit

protocol PostsListView: AnyObject {
    func isLoading(_ loading: Bool)
    func set(title: String)
    func reloadData()
    func offlineLabel(title: String)
    func offlineLabel(isHidden: Bool)
    func showError()
}

final class PostsListViewController: UIViewController {
    var offlineMessageLabel: UILabel?
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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension

        self.tableView = tableView
        view.addSubviewFillingParent(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        presenter.viewDidLoad()
    }

    @objc private func refresh() {
        presenter.refresh()
    }
}

extension PostsListViewController: PostsListView {
    func isLoading(_ loading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        tableView?.isHidden = loading
        if !loading {
            tableView?.refreshControl?.endRefreshing()
        }
    }
    func set(title: String) {
        navigationItem.title = title
    }
    func reloadData() {
        tableView?.reloadData()
    }
    func offlineLabel(title: String) {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        tableView?.tableHeaderView = label
        label.sizeToFit()
    }
    func offlineLabel(isHidden: Bool) {
        tableView?.tableHeaderView?.isHidden = isHidden
    }
    func showError() {

    }
}

extension PostsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: PostTableViewCell = tableView.dequeue(defaultCell: .init(style: .subtitle,
                                                                           reuseIdentifier: PostTableViewCell.id))

        presenter.set(cell: cell, at: indexPath.row)
        return cell
    }
}

extension PostsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath.row)
    }

}
