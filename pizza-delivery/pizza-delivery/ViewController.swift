//
//  ViewController.swift
//  pizza-delivery
//
//  Created by Igor Karpov on 30.04.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            self.f1()
            self.f2()
            self.f3()
            self.f4()
        }
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
