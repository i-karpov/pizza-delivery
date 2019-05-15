//
//  BaseOrderFlowViewController.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 10.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class BaseOrderFlowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
    
    func setupNavbar() {
        navigationController?.navigationBar.backIndicatorImage
            = UIImage(named: "navbar-back-button")?.withInsets(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navbar-back-button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: UIBarButtonItem.Style.plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        navigationItem.backBarButtonItem?.accessibilityLabel = AccessibilityIdentitier.Order.CommonButton.backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "navbar-close-button"),
            style: .plain,
            target: self,
            action: #selector(handleCloseTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        navigationItem.rightBarButtonItem?.accessibilityLabel = AccessibilityIdentitier.Order.CommonButton.closeButton
    }
    
    @objc
    func handleCloseTapped() {
        fatalError("Should be implemented in child class.")
    }
    
}
