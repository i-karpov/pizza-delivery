//
//  pizza_delivery_unit_tests.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 30.04.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest
@testable import pizza_delivery

class pizza_delivery_unit_tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Arrange
        let testService = TestService()
        
        // Act
        let is123Palindrome = testService.checkIsPalindrome(123)
        
        // Assert
        XCTAssertFalse(is123Palindrome, "Wrong: treats 123 as palindrom.")
    }

}
