//
//  CompositionRoot.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class CompositionRoot {
    
    var navigator: SceneNavigatorProtocol!
    private let serviceFactory: ServiceFactoryProtocol
    
    private let urlsConfig: UrlsConfigProtocol
    private let api: APIProtocol
    private let dtoToModelMapper: DtoToModelMapper
    private let modelToDtoMapper: ModelToDtoMapper
    private let menuService: MenuServiceProtocol
    private let orderService: OrderServiceProtocol
    private let errorToTextMapper: ErrorToTextMapper
    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
        
        urlsConfig = ProdUrlsConfig()
        api = API(urlsConfig: urlsConfig)
        dtoToModelMapper = DtoToModelMapper()
        modelToDtoMapper = ModelToDtoMapper()
        menuService = MenuService(api: api, mapper: dtoToModelMapper)
        orderService = OrderService(api: api,
                                    dtoToModelMapper: dtoToModelMapper,
                                    modelToDtoMapper: modelToDtoMapper)
        errorToTextMapper = ErrorToTextMapper()
    }
    
    func composeFlow(_ flow: Flow) -> FlowProtocol {
        switch flow {
        case .order(let initData):
            return OrderFlow(navigator: navigator, initData: initData)
        }
    }
    
    func composeScene(_ scene: Scene) -> UIViewController {
        switch scene {
        case .splash:
            return SceneFactory.makeSplash(navigator: navigator)
        case .menu:
            return SceneFactory.makeMenu(navigator: navigator,
                                         menuService: menuService,
                                         errorToTextMapper: errorToTextMapper)
        case .ordersHistory:
            return SceneFactory.makeOrdersHistory(navigator: navigator)
        case .tabs:
            return SceneFactory.makeTabs(
                navigator: navigator,
                menuScene: composeScene(.menu),
                ordersHistoryScene: composeScene(.ordersHistory))
        case .order(let orderScene):
            return composeOrderScene(orderScene)
        }
    }
    
    // MARK: - Private
    
    private func composeOrderScene(_ orderScene: Scene.Order) -> UIViewController {
        switch orderScene {
        case .selectAddress(let initData):
            let viewController = SceneFactory.makeSelectAddress(navigator: navigator,
                                                                initData: initData,
                                                                orderService: orderService,
                                                                errorToTextMapper: errorToTextMapper)
            return UINavigationController(rootViewController: viewController)
        case .enterDeliveryDetails(let initData):
            return SceneFactory.makeEnterDeliveryDetails(navigator: navigator, initData: initData)
        case .selectPaymentMethod(let initData):
            return SceneFactory.makeSelectPaymentMethod(navigator: navigator, initData: initData)
        case .confirmOrder(let initData):
            return SceneFactory.makeConfirmOrder(navigator: navigator,
                                                 initData: initData,
                                                 orderService: orderService,
                                                 errorToTextMapper: errorToTextMapper)
        case .success(let initData):
            return SceneFactory.makeOrderSuccessScreen(navigator: navigator, initData: initData)
        }
    }
    
    private func composeScene<T: UIViewController>(_ scene: Scene) -> T {
        guard let sceneModul = composeScene(scene) as? T else {
            fatalError("Could not compose scene: \(scene)")
        }
        return sceneModul
    }
}
