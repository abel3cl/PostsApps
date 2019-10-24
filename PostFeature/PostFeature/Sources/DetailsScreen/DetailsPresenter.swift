import Core
import Adapter

protocol DetailsPresenterProtocol {
    func viewDidLoad()
    func attachView(_ view: DetailsView)
}

final class DetailsPresenter {
    weak var view: DetailsView?
    let post: Post

    let coordinator: PostCoordinator
    let commentAdapter: PostAdapterComment
    let userAdapter: PostAdapterUser
    let localizer: DetailsLocalizer

    init(post: Post,
         coordinator: PostCoordinator,
         commentAdapter: PostAdapterComment,
         userAdapter: PostAdapterUser,
         localizer: DetailsLocalizer = DetailsLocalizer()) {
        self.post = post
        self.coordinator = coordinator
        self.commentAdapter = commentAdapter
        self.userAdapter = userAdapter
        self.localizer = localizer
    }

    private func handleUserResult(result: Result<User, AdapterError>) {
        switch result {
        case .success(let user):
            view?.set(authorValue: user.name)
            view?.set(emailValue: user.email)
        case .failure(let error):
            view?.showError(error)
        }
    }

    private func handleCommentsResult(result: Result<[Comment], AdapterError>) {
        var errorMessage: String?
        switch result {
        case .success(let comments):
            let value = localizer.localizedString(key: .numberOfComments, num: comments.count)

            let numberOfComments = localizer.localize(key: .numberOfCommentsTitle)
                .replacingOccurrences(of: Constants.replacement,
                                      with: value)

            view?.set(numberOfCommentsIsHidden: false)
            view?.set(numberOfComments: numberOfComments)
        case .failure(.noConection):
            errorMessage = localizer.localize(key: .errorNoConnection)
            fallthrough
        case .failure:
            let errorMessage = errorMessage ?? localizer.localize(key: .errorDefault)
            view?.set(numberOfCommentsIsHidden: false)
            view?.set(numberOfComments: errorMessage)
        }
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {

    func viewDidLoad() {
        view?.set(title: localizer.localize(key: .title))

        view?.set(authorTitle: localizer.localize(key: .author))
        view?.set(emailTitle: localizer.localize(key: .email))
        view?.set(numberOfCommentsIsHidden: true)
        view?.isLoading(true)
        view?.set(authorValue: localizer.localize(key: .loading))
        view?.set(emailValue: localizer.localize(key: .loading))
        view?.set(body: post.body)

        userAdapter.getUserDetails(post: post, completion: handleUserResult)
        commentAdapter.getComments(post: post, completion: handleCommentsResult)
    }

    func attachView(_ view: DetailsView) {
        self.view = view
    }
}
