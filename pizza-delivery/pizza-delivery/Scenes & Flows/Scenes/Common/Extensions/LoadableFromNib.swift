//
//  LoadableFromNib.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

protocol LoadableFromNib {
    func loadFromNib()
}

extension LoadableFromNib where Self: UIView {
    
    func loadFromNib() {
        let viewType = type(of: self)
        let viewName = String(describing: viewType)
        let bundle = Bundle(for: viewType)
        let nib = UINib(nibName: viewName, bundle: bundle)
        
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Cannot load view from nib")
        }
        
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
    }
    
}
