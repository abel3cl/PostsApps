import Core
import Networking

struct PostAdapterCommandFactory {

    let context: AdapterContext

    func getPost() -> HTTPCommand<[PostResponse], [Post]> {
        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.Posts.path])

        return HTTPCommand(request: request,
                           decode: [PostResponse].self,
                           map: { return $0.map(Post.init) })
    }

    func getUserDetails(post: Post) -> HTTPCommand<UserResponse, User> {
        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.User.path, "\(post.userId)"])

        return HTTPCommand(request: request,
                           decode: UserResponse.self,
                           map: User.init)

    }

    func getComments(post: Post) -> HTTPCommand<[CommentResponse], [Comment]> {
        let queryParams = [Constants.Comments.postId: "\(post.id)"]
        let request = HTTPRequest.get(url: context.baseUrl)
            .with(pathComponents: [Constants.Comments.path],
                  queryParams: queryParams)

        return HTTPCommand(request: request,
                           decode: [CommentResponse].self,
                           map: { return $0.map(Comment.init) })
    }
}
