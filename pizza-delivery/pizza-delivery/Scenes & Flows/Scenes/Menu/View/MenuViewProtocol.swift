import Foundation

protocol MenuViewProtocol: class {

    func setIsAcitityIndicatorVisible(_ isVisible: Bool)
    func showTextForError(_ error: CommonError)
    func showTextWithRetryForError(_ error: CommonError)
    
    func setPizzas(_ pizzas: [Pizza])
    
}
