import Foundation

protocol SelectAddressViewProtocol: class {

    func setIsAcitityIndicatorVisible(_ isVisible: Bool)
    func showTextForError(_ error: CommonError)
    
    func setIsStreetInputEnabled(_ isEnabled: Bool)
    func setIsBuildingInputEnabled(_ isEnabled: Bool)
    func setIsNextButtonEnabled(_ isEnabled: Bool)
    
    func setAvailableStreets(_ streets: [Street])
    func setAvailableBuildings(_ buildings: [Building])
    
    func eraseBuildingInput()
}
