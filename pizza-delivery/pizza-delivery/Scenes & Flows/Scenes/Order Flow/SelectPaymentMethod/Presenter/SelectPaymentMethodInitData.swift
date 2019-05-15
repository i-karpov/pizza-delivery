import Foundation

struct SelectPaymentMethodInitData {
    
    // MARK: - Input
    
    let totalPrice: MoneyAmount
    
    // MARK: - Output
    
    let handleCloseTapped: CommonBlock.EmptyAction
    let handleEnteringFinished: CommonBlock.Action<PaymentMethod>
}
