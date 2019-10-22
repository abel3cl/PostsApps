import Core

final class DetailsLocalizer: Localizable {
    let tableName = "LocalizableDetailsScreen"

    enum LocalizableKey: String {
        case title = "details.title"
        case author = "details.author"
        case email = "details.email"

        case loading = "details.loading"

        case numberOfCommentsTitle = "details.numberOfCommentsTitle"
        case numberOfComments = "details.numberOfComments"

        case errorNoConnection = "error.noConnection"
        case errorDefault = "error.default"
    }
}
