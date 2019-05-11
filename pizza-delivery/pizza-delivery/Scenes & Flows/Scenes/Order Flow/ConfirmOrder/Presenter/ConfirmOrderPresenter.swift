import Foundation

class ConfirmOrderPresenter {

    private unowned let view: ConfirmOrderViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: ConfirmOrderInitData
    private let orderService: OrderServiceProtocol

    init(view: ConfirmOrderViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: ConfirmOrderInitData,
         orderService: OrderServiceProtocol) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
        self.orderService = orderService
    }

}

// MARK: - Presenter Protocol

extension ConfirmOrderPresenter: ConfirmOrderPresenterProtocol {

    func handleViewLoaded() {
        view.showOrderDraft(initData.orderDraft)
    }
    
    func handleCloseTapped() {
        initData.handleCloseTapped()
    }
    
    func handleErrorDismissed() {
        initData.handleCloseTapped()
    }
    
    func handleOrderConfirmed() {
        view.setIsAcitityIndicatorVisible(true)
        orderService.sendOrder(initData.orderDraft) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.view.setIsAcitityIndicatorVisible(false)
            
            switch result {
            case .success(let deliveryTime):
                strongSelf.initData.handleOrderSentSuccessully(deliveryTime)
            case .failure(let error):
                strongSelf.view.showTextForError(error)
            }
        }
    }

}
