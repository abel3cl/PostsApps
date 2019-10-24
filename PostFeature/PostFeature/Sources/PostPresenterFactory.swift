import Core
import Adapter

struct PostPresenterFactory {
    let postAdapter: PostAdapter

    func getPostsPresenter(coordinator: PostCoordinator) -> PostsPresenterProtocol {
        let storage: AnyStorage<Post>

        if !wasLaunched(with: .uiTest) {
            guard let fileStorage = FileStorage<Post>() else { fatalError() }
            storage = AnyStorage(fileStorage)
        } else {
            let memoryStorage = MemoryStorage<Post>()
            storage = AnyStorage(memoryStorage)
        }

        return PostsPresenter(coordinator: coordinator, storage: storage, adapter: postAdapter.post)
    }

    func getDetailsPresenter(post: Post,
                             coordinator: PostCoordinator) -> DetailsPresenterProtocol {

        return DetailsPresenter(post: post,
                                coordinator: coordinator,
                                commentAdapter: postAdapter.comment,
                                userAdapter: postAdapter.user)
    }
}
extension PostPresenterFactory: LaunchArgumentExecutable {}
