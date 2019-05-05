//
//  UICollectionView+ReusableCells.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let reuseIdentifier = getReuseIdentifierFor(T.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = getReuseIdentifierFor(T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(reuseIdentifier)")
        }
        return cell
    }
    
    private func getReuseIdentifierFor(_ type: Any) -> String {
        return String(describing: type)
    }
}
