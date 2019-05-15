import Foundation
import Swifter

class POSTAddPizzaEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let successfulResponse = "AddPizzaSuccessfulResponse"
    }
    
    let path = "/api/v1/basket/add-item"
    let httpMethod: HttpMethod = .POST
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        return HttpResponse.ok(.json(responseJSON))
    }
}
