import Foundation

extension URL {
    var queryParameters: [String: String]? {
        var params = [String: String]()
        let queryItems = URLComponents(string: self.absoluteString)?.queryItems
        queryItems?.forEach { params[$0.name] = $0.value }
        return params
    }
}
