import Core
import Adapter

struct PostPresenterFactory {
    let postAdapter: PostAdapter
    func getPostsPresenter(coordinator: PostCoordinator) -> PostsPresenterProtocol {
        return PostsPresenter(coordinator: coordinator, adapter: postAdapter.post)
    }

    func getDetailsPresenter(post: Post,
                             coordinator: PostCoordinator) -> DetailsPresenterProtocol {
        return DetailsPresenter(post: post,
                                coordinator: coordinator,
                                commentAdapter: postAdapter.comment,
                                userAdapter: postAdapter.user)
    }
}
