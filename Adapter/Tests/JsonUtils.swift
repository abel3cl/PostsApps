import Foundation

final class JsonUtils {
    static func load(file: String) -> Data {
        do {
            guard let url = Bundle(for: JsonUtils.self).url(forResource: file, withExtension: "json") else {
                fatalError("\(file) not found")
            }
            let data = try Data(contentsOf: url)
            return data

        } catch {
            fatalError("\(file) not found")
        }
    }
}
