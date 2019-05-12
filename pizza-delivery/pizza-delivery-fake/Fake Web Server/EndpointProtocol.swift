import Foundation
import Swifter

protocol EndpointProtocol {

    var path: String { get }
    var httpMethod: HttpMethod { get }

    func handleRequest(_ request: HttpRequest) -> HttpResponse
}
