import Foundation

class ConfirmOrderPresenter {

    private unowned let view: ConfirmOrderViewProtocol
    private unowned let navigator: SceneNavigatorProtocol
    
    private let initData: ConfirmOrderInitData

    init(view: ConfirmOrderViewProtocol,
         navigator: SceneNavigatorProtocol,
         initData: ConfirmOrderInitData) {
        self.view = view
        self.navigator = navigator
        self.initData = initData
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
    
    func handleOrderConfirmed() {
        // TODO: calculate real delivery time
        initData.handleOrderSentSuccessully(DeliveryWaitingTime(minutes: 60))
    }

}
