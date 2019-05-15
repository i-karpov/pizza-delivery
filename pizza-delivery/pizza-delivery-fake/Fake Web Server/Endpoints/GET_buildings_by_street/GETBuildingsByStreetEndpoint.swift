import Foundation
import Swifter

class GETBuildingsByStreetEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let defaultSuccessfulResponse = "BuildingsDefaultSuccessfulResponse"
        static let successfulResponseForStreet223 = "BuildingsAtStreet223SuccessfulResponse"
    }
    
    let path = "/api/v1/streets/:streetId"
    let httpMethod: HttpMethod = .GET
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        
        let streetId = request.params[":streetId"]
        let responseResource = streetId == "223"
            ? JSONResource.successfulResponseForStreet223
            : JSONResource.defaultSuccessfulResponse
        
        let responseJSON = JSONLoader.loadFromResource(responseResource)
        Thread.sleep(forTimeInterval: 2.0)
        return HttpResponse.ok(.json(responseJSON))
    }
}
