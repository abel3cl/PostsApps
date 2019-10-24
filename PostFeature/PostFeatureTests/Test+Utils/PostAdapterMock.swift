import Core
import Adapter

final class PostAdapterMock: PostAdapter {
    var post: PostAdapterList = PostAdapterListMock()
    var user: PostAdapterUser = PostAdapterUserMock()
    var comment: PostAdapterComment = PostAdapterCommentMock()
}

final class PostAdapterListMock: PostAdapterList {
    var getPostsCount: Int = 0
    var getPosts: Result<[Post], AdapterError>!
    func getPosts(completion: @escaping (Result<[Post], AdapterError>) -> Void) {
        getPostsCount += 1
        completion(getPosts)
    }
}

final class PostAdapterUserMock: PostAdapterUser {
    var getUserDetailsCount: Int = 0
    var getUserDetails: Result<User, AdapterError>!
    func getUserDetails(post: Post, completion: @escaping (Result<User, AdapterError>) -> Void) {
        getUserDetailsCount += 1
        completion(getUserDetails)
    }
}

final class PostAdapterCommentMock: PostAdapterComment {
    var getCommentsCount: Int = 0
    var getComments: Result<[Comment], AdapterError>!
    func getComments(post: Post, completion: @escaping (Result<[Comment], AdapterError>) -> Void) {
        getCommentsCount += 1
        completion(getComments)
    }


}
