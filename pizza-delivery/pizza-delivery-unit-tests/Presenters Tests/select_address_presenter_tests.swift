//
//  File.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 08.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest
@testable import pizza_delivery

class select_address_presenter_tests: XCTestCase {
    
    // MARK: - Properties
    
    private var mockNavigator: MockSceneNavigator!
    private var mockOrderService: MockOrderService!
    private var mockSelectAddressView: MockSelectAddresssView!
    
    private var presenter: SelectAddressPresenterProtocol!
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        mockNavigator = MockSceneNavigator()
        mockOrderService = MockOrderService()
        mockSelectAddressView = MockSelectAddresssView()
        
        let initData = SelectAddressInitData(
            handleCloseTapped: {},
            handleEnteringFinished: { (streetAndBuilding) in
                
        })
        
        presenter = SelectAddressPresenter(view: mockSelectAddressView,
                                           navigator: mockNavigator,
                                           initData: initData,
                                           orderService: mockOrderService)
    }
    
    // MARK: - Tests
    
    func test_when_view_loaded_then_inputs_and_next_button_are_disabled() {
        XCTFail("Not implemented")
    }
    
    func test_when_view_loaded_then_streets_get_loaded_and_then_only_street_input_becomes_enabled() {
        XCTFail("Not implemented")
    }
    
    func test_when_streets_loading_failed_then_error_is_shown() {
        XCTFail("Not implemented")
    }
    
    func test_when_error_dismissed_then_scene_gets_closed() {
        XCTFail("Not implemented")
    }
    
    func test_when_steet_picked_then_buildings_get_loaded_for_this_street() {
        XCTFail("Not implemented")
    }
    
    func test_when_steet_picked_then_buidling_is_erased_and_next_button_is_disabled() {
        XCTFail("Not implemented")
    }
    
    func test_when_building_picked_then_next_button_becomes_enabled() {
        XCTFail("Not implemented")
    }
    
    func test_when_address_picked_and_next_tapped_then_scene_returns_entered_address() {
        XCTFail("Not implemented")
    }
    
    func test_when_address_picked_and_updated_and_next_tapped_then_scene_returns_updated_address() {
        XCTFail("Not implemented")
    }
}
