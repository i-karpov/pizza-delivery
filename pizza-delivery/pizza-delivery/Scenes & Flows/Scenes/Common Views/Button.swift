//
//  Button.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            setColorsForState(isEnabled: isEnabled)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        isEnabled = true
    }
    
    private func setColorsForState(isEnabled: Bool) {
        if isEnabled {
            applyGradientFromLeftToRight(colors: [#colorLiteral(red: 1, green: 0.2941176471, blue: 0.168627451, alpha: 1), #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4235294118, alpha: 1)])
        } else {
            applyGradientFromLeftToRight(colors: [#colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1), #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)])
        }
    }
}
