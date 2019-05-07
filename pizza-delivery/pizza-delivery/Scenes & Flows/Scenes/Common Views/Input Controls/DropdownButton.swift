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
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var tappableArea: UIView!
    
    var isEnabled: Bool = true {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
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
    
    @IBAction func handleTapped(_ sender: Any) {
        guard isEnabled else {
            return
        }
        print("TAPPED")
    }
    
    // MARK: - Init UI
    
    private func commonInit() {
        loadFromNib()
    tappableArea.layer.cornerRadius = 5.0
        tappableArea.layer.masksToBounds = true
        
        valueLabel.text = .none
    }
    
    // MARK: - Public Methods
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
}
