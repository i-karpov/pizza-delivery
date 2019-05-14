import Foundation

class JSONLoader {

    static func loadFromResource(_ name: String) -> AnyObject {

        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            fatalError("Unable to find json-resource.")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data)
            return jsonResult as AnyObject
        } catch {
            fatalError("Unable to load json-resource.")
        }
    }
}
