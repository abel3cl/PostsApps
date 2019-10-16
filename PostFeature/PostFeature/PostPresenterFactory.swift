import Foundation

struct PostPresenterFactory {
    let postAdapter: PostsAdapter
    func getPostsPresenter() -> PostsPresenterProtocol {
        return PostsPresenter(adapter: postAdapter)
    }
}
