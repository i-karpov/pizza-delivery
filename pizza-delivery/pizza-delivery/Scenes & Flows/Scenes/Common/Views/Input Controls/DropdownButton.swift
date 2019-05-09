//
//  DropdownButton.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class DropdownButton: UIView, LoadableFromNib {

    struct ItemDescriptor {
        let displayTitle: String
        let item: Any
    }
    
    // MARK: - Prperties
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var tappableArea: UIView!
    
    private let supportingTextField = UITextField()
    private let picker = UIPickerView()
    private let pickerToolbar = UIToolbar()
    
    var isEnabled: Bool = true {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    var handleValueChanged: CommonBlock.Action<ItemDescriptor?>? = .none
    
    private var selectedIndex: Int? = .none {
        didSet {
            guard selectedIndex != oldValue else {
                return
            }
            
            var selectedDescriptor: ItemDescriptor? = .none
            if let index = selectedIndex {
                selectedDescriptor = availableItemDescriptors[index]
            }
            
            valueLabel.text = selectedDescriptor?.displayTitle
            handleValueChanged?(selectedDescriptor)
        }
    }
    private var availableItemDescriptors: [ItemDescriptor] = []
    
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
        supportingTextField.becomeFirstResponder()
    }
    
    // MARK: - Init UI
    
    private func commonInit() {
        loadFromNib()
        
        tappableArea.layer.cornerRadius = 5.0
        tappableArea.layer.masksToBounds = true
        tappableArea.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        
        valueLabel.text = .none
        
        pickerToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: R.string.localizable.commonPickerButtonsDone(),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(handleItemPicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: R.string.localizable.commonPickerButtonsCancel(),
                                           style: UIBarButtonItem.Style.plain,
                                           target: self,
                                           action: #selector(handlePickingCanceled))
        pickerToolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        supportingTextField.isHidden = true
        addSubview(supportingTextField)
        supportingTextField.inputAccessoryView = pickerToolbar
        supportingTextField.inputView = picker
        picker.dataSource = self
        picker.delegate = self
    }
    
    // MARK: - Public Methods
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    func clear() {
        selectedIndex = .none
        availableItemDescriptors = []
    }
    
    func setAvailableItems(_ availableItemDescriptors: [ItemDescriptor]) {
        self.availableItemDescriptors = availableItemDescriptors
    }
    
    // MARK: - Private methods
    
    @objc
    func handleItemPicked() {
        selectedIndex = picker.selectedRow(inComponent: 0)
        supportingTextField.resignFirstResponder()
    }
    
    @objc
    func handlePickingCanceled() {
        supportingTextField.resignFirstResponder()
    }
}

// MARK: - Picker Data Source & Delegate

extension DropdownButton: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableItemDescriptors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableItemDescriptors[row].displayTitle
    }
}
