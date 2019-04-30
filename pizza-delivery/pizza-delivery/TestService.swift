//
//  TestService.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 30.04.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import Foundation

class TestService {
    
    func checkIsPalindrome(_ string: String) -> Bool {
        return string == String(string.reversed())
    }
    
    func checkIsPalindrome(_ int: Int) -> Bool {
        guard int >= 0 else {
            return false
        }
        
        let isPalindrome = checkIsPalindrome("\(int)")
        return true//isPalindrome
    }
    
}
