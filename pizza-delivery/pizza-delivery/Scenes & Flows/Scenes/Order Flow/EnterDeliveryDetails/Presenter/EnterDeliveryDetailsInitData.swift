import Foundation

struct EnterDeliveryDetailsInitData {
    
    // MARK: - Input
    
    let selectedStreet: Street
    let selectedBuilding: Building
    
    // MARK: - Output
    
    let handleCloseTapped: CommonBlock.EmptyAction
    let handleEnteringFinished: CommonBlock.Action<DeliveryDetails>
}
