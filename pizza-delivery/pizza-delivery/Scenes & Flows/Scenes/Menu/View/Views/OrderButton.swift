//
//  OrderButton.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class OrderButton: UIButton {
    
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
        applyGradientFromLeftToRight(colors: [#colorLiteral(red: 1, green: 0.2941176471, blue: 0.168627451, alpha: 1), #colorLiteral(red: 1, green: 0.2549019608, blue: 0.4235294118, alpha: 1)])
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 19)
    }

}
