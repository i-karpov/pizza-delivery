import Foundation

protocol ConfirmOrderViewProtocol: class {

    func setIsAcitityIndicatorVisible(_ isVisible: Bool)
    func showTextForError(_ error: CommonError)
    
    func showOrderDraft(_ orderDraft: OrderDraft)
    
}
