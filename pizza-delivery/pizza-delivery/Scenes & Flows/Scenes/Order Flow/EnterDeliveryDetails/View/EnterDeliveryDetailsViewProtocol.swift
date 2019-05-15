import Foundation

protocol EnterDeliveryDetailsViewProtocol: class {

    func setStreet(_ street: Street)
    func setBuilding(_ building: Building)
    
    func setIsNextButtonEnabled(_ isEnabled: Bool)
}
