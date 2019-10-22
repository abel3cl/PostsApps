import Core

extension Post {
    init(withResponse response: PostResponse) {
        self.init(userId: response.userId,
                  id: response.id,
                  title: response.title,
                  body: response.body)

    }
}
