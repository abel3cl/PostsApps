import Foundation

final class JsonUtils {
    static func load(file: String) -> Any {
        do {
            guard let url = Bundle(for: JsonUtils.self).url(forResource: file, withExtension: "json") else {
                fatalError("\(file) not found")
            }
            let data = try Data(contentsOf: url)

            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)

        } catch {
            fatalError("\(file) not found")
        }
    }
}
