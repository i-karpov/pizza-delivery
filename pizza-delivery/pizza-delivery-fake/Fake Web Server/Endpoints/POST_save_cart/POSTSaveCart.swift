import Foundation
import Swifter

class POSTSaveCartEndpoint: EndpointProtocol {
    
    private enum JSONResource {
        static let successfulResponse = "SaveCartSuccessfulResponse"
    }
    
    let path = "/api/v1/basket/save"
    let httpMethod: HttpMethod = .POST
    
    func handleRequest(_ request: HttpRequest) -> HttpResponse {
        let responseJSON = JSONLoader.loadFromResource(JSONResource.successfulResponse)
        Thread.sleep(forTimeInterval: 0.5)
        return HttpResponse.ok(.json(responseJSON))
    }
}
