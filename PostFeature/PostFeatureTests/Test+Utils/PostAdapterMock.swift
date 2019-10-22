import Core
import Adapter

final class PostAdapterMock: PostAdapter {
    var post: PostAdapterList = PostAdapterListMock()
    var user: PostAdapterUser = PostAdapterUserMock()
    var comment: PostAdapterComment = PostAdapterCommentMock()
}

final class PostAdapterListMock: PostAdapterList {
    var getPosts: Result<[Post], AdapterError>!
    func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void) {
        completion(getPosts)
    }
}

final class PostAdapterUserMock: PostAdapterUser {
    var getUserDetails: Result<User, AdapterError>!
    func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void) {
        completion(getUserDetails)
    }
}

final class PostAdapterCommentMock: PostAdapterComment {
    var getComments: Result<[Comment], AdapterError>!
    func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void) {
        completion(getComments)
    }


}
