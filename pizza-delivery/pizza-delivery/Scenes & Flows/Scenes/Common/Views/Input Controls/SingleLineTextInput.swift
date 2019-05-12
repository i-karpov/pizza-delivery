//
//  SingleLineTextInput.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class SingleLineTextInput: UIView, LoadableFromNib {
    
    // MARK: - Prperties
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var textField: UITextField!
    
    var isEnabled: Bool = true {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
            textField.isEnabled = isEnabled
        }
    }
    
    var handleValueChanged: CommonBlock.Action<String?>? = .none
    
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
        textField.layer.cornerRadius = 5.0
        textField.layer.masksToBounds = true
        
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 9.0, height: 40.0))
        leftView.backgroundColor = .clear
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 9.0, height: 40.0))
        rightView.backgroundColor = .clear
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        textField.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        setupFonts()
    }
    
    private func setupFonts() {
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        titleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
    }
    
    // MARK: - Public Methods
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    func setValue(_ value: String?) {
        let olfValue = textField.text
        textField.text = value
        if value != olfValue {
            handleValueChanged?(textField.text)
        }
    }
    
    // MARK: - Private Methods
    
    @objc
    private func textFieldDidChange() {
        handleValueChanged?(textField.text)
    }
}
