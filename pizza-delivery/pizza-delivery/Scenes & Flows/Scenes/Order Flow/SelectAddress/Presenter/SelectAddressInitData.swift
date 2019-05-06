import Foundation

struct SelectAddressInitData {
    
    struct SelectAddressSceneOutput {
        let street: Street
        let buidling: Building
    }
    
    let handleCloseTapped: CommonBlock.EmptyAction
    let handleEntering: CommonBlock.Action<SelectAddressSceneOutput>
    
}
