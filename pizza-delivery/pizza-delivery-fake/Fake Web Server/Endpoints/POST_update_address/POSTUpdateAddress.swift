import Foundation
import Swifter

class POSTUpdateAddressEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let successfulResponse = "UpdateAddressSuccessfulResponse"
    }
    
    let path = "/api/v1/basket/update-address"
    let httpMethod: HttpMethod = .POST
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        return HttpResponse.ok(.json(responseJSON))
    }
}
