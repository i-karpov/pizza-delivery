import Foundation
import Swifter

class GETSettingsEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let successfulResponse = "SettingsSuccessfulResponse"
    }
    
    let path = "/api/v1/settings"
    let httpMethod: HttpMethod = .GET
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        return HttpResponse.ok(.json(responseJSON))
    }
}
