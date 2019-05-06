//
//  UIViewController+Alerts.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 06.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let buttonTitle = R.string.localizable.commonAlertOkButton()
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
