import Core
import Adapter

struct PostPresenterFactory {
    let postAdapter: PostAdapter
    func getPostsPresenter(coordinator: PostCoordinator) -> PostsPresenterProtocol {
        guard let fileStorage = FileStorage<Post>() else { fatalError() }
        let storage = AnyStorage(fileStorage)
        return PostsPresenter(coordinator: coordinator, storage: storage, adapter: postAdapter.post)
    }

    func getDetailsPresenter(post: Post,
                             coordinator: PostCoordinator) -> DetailsPresenterProtocol {
        guard let fileStorage = FileStorage<Post>() else { fatalError() }

        return DetailsPresenter(post: post,
                                coordinator: coordinator,
                                commentAdapter: postAdapter.comment,
                                userAdapter: postAdapter.user)
    }
}
