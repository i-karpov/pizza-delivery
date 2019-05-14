import Foundation
import Swifter

class GETStreetsEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let successfulResponse = "StreetsSuccessfulResponse"
    }
    
    let path = "/api/v1/streets"
    let httpMethod: HttpMethod = .GET
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        return HttpResponse.ok(.json(responseJSON))
    }
}
