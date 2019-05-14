import Foundation
import Swifter

class FakeWebServer {

    static let shared = FakeWebServer()
    
    private let server: HttpServer

    private init() {
        server = HttpServer()
        addEndpointsToServer(server)
    }

    func start() {
        do {
            try server.start()
        } catch {
            fatalError("FakeWebServer failed to start.")
        }
    }

    private func addEndpointsToServer(_ server: HttpServer) {

        let endpoints: [EndpointProtocol] = [
            GETPizzasEndpoint(),
            GETStreetsEndpoint(),
            GETBuildingsByStreetEndpoint()
        ]
            
        endpoints.forEach {
            var serverRoute = getRoute(in: server, for: $0.httpMethod)
            serverRoute[$0.path] = $0.handleRequest
        }
    }

    func getRoute(in server: HttpServer, for method: HttpMethod) -> HttpServer.MethodRoute {
        let methodsToRouteGettersMap: [HttpMethod: (HttpServer) -> HttpServer.MethodRoute] = [
            .GET: { $0.GET },
            .POST: { $0.POST },
            .DELETE: { $0.DELETE },
            .PATCH: { $0.PATCH },
            .HEAD: { $0.HEAD },
            .PUT: { $0.PUT }
        ]
        guard let route = methodsToRouteGettersMap[method]?(server) else {
            fatalError()
        }
        return route
    }
}
