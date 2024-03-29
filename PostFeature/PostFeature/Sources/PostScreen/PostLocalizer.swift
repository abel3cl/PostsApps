import Core

final class PostLocalizer: Localizable {
    let tableName = "LocalizablePostScreen"

    enum LocalizableKey: String {
        case title = "post.title"
        case cellTitle = "cell.title"
        case cellSubtitle = "cell.subtitle"

        case dataFrom = "post.dataFrom"

        case errorDefault = "error.default"
    }
}
