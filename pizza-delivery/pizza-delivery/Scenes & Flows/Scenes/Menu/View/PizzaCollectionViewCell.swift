//
//  PizzaCollectionViewCell.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PizzaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var contentWrapper: UIView!
    @IBOutlet weak private var pizzaImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var orderButton: UIButton!
    @IBOutlet weak private var widthConstraint: NSLayoutConstraint!
    
    private var handleOrderTapped: (() -> Void)?
    
    // MARK: - Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthConstraint.constant = UIScreen.main.bounds.size.width
        contentView.addSubview(contentWrapper)
        titleLabel.accessibilityIdentifier = AccessibilityIdentitier.Menu.pizzaCellTitle
        priceLabel.accessibilityIdentifier = AccessibilityIdentitier.Menu.pizzaCellPrice
        
        orderButton.titleLabel?.text = R.string.localizable.menuOrderButtonTitle()
    }
    
    func configureWithPizza(_ pizza: Pizza,
                            onOrderTapped handleOrderTapped: @escaping () -> Void) {
        pizzaImage.image = nil
        titleLabel.text = pizza.title
        priceLabel.text = makeFormattedStringFromPrice(pizza.price)
        pizzaImage.kf.setImage(with: URL(string: pizza.smallImageUrl))
        self.handleOrderTapped = handleOrderTapped
    }
    
    private func makeFormattedStringFromPrice(_ price: Price) -> String {
        let mainPart = price.cents / 100
        let centsPart = price.cents % 100
        return "\(mainPart),\(centsPart)"
    }
    
    // MARK: - Signals Handling
    
    @IBAction private func handleOrderButtonTapped() {
        handleOrderTapped?()
    }
}
