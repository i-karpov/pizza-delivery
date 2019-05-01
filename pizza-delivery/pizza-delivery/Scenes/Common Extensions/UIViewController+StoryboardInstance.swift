//
//  UIViewController+StoryboardInstance.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 01.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func storyboardInstance<T>() -> T {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()
        
        guard let resViewController = viewController as? T else {
            fatalError("Cannot load view controller from storyboard")
        }
        
        return resViewController
    }
    
}
