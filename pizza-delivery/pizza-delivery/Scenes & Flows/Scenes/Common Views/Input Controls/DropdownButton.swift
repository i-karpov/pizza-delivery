//
//  DropdownButton.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class DropdownButton: UIView, LoadableFromNib {

    // MARK: - Prperties
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Events
    
    // MARK: - Init UI
    
    private func commonInit() {
        loadFromNib()
    }
}
