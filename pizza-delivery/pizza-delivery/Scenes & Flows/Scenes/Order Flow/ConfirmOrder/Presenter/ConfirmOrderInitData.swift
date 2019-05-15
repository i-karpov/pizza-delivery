import Foundation

struct ConfirmOrderInitData {
    
    // MARK: - Input
    
    let orderDraft: OrderDraft
    
    // MARK: - Output
    
    let handleCloseTapped: CommonBlock.EmptyAction
    let handleOrderSentSuccessully: CommonBlock.Action<DeliveryWaitingTime>
}
