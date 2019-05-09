//
//  UIImage+Insets.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 07.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

extension UIImage {
    
    func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom),
            false,
            scale)
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
    
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
    
}
