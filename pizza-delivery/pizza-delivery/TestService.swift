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
        // efkesfliseuhfilweshf liawef lawe fwile fewfwe weilfuhwaf wlfhawlief wf walifu hwa fwefi ulwahf w
        return string == String(string.reversed())
    }
    
    func checkIsPalindrome(_ int: Int) -> Bool {
        guard int >= 0 else {
            return false
        }
        
        let isPalindrome = checkIsPalindrome("\(int)")
        return isPalindrome
    }
    
    private func f1() {
        print("hello")
    }
    
    private func f2() {
        print("hello")
    }
    
    private func f3() {
        print("hello")
    }
    
    private func f4() {
        print("hello")
    }
}
