import Foundation
import Swifter

class GETPizzasEndpoint: EndpointProtocol {

    private enum JSONResource {
        static let successfulResponse = "PizzasSuccessfulResponse"
    }
    
    let path = "/api/v1/pizzas"
    let httpMethod: HttpMethod = .GET

    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        return HttpResponse.ok(.json(responseJSON))
    }
}
