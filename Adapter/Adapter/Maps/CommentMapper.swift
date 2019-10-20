import Core

extension Comment {
    init(withResponse response: CommentResponse) {
        self.init(postId: response.postId,
                  id: response.id,
                  name: response.name,
                  email: response.email,
                  body: response.body)

    }
}
