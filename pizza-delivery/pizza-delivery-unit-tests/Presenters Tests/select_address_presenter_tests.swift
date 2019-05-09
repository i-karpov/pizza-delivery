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
    private var mockView: MockSelectAddresssView!
    
    private var presenter: SelectAddressPresenterProtocol!
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        mockNavigator = MockSceneNavigator()
        mockOrderService = MockOrderService()
        mockView = MockSelectAddresssView()
        
        let initData = SelectAddressInitData(
            handleCloseTapped: {},
            handleEnteringFinished: { (streetAndBuilding) in
                
        })
        
        presenter = SelectAddressPresenter(view: mockView,
                                           navigator: mockNavigator,
                                           initData: initData,
                                           orderService: mockOrderService)
    }
    
    // MARK: - Tests
    
    func test_when_view_loaded_then_inputs_and_next_button_are_disabled() {
        
        // Arrange
        mockOrderService.responses.getStreetsAsync = .success([])
        
        // Act
        presenter.handleViewLoaded()
        
        // Assert
        
        let streetAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsStreetEnabled($0)
        }
        let buildingAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsBuildingEnabled($0)
        }
        let buttonAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsNextButtonEnabled($0)
        }
        
        XCTAssert(streetAvailabilityOperations.count > 0)
        if streetAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsStreetEnabled(streetAvailabilityOperations.last!,
                                                                        withParam: false),
                      "Street input is not disabled.")
        }
        XCTAssert(buildingAvailabilityOperations.count > 0)
        if buildingAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsBuildingEnabled(buildingAvailabilityOperations.last!,
                                                                          withParam: false),
                      "Building input is not disabled.")
        }
        XCTAssert(buttonAvailabilityOperations.count > 0)
        if buttonAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsNextButtonEnabled(buttonAvailabilityOperations.last!,
                                                                            withParam: false),
                      "Next button is not disabled.")
        }
        
    }
    
    func test_when_view_loaded_then_streets_get_loaded_and_then_only_street_input_becomes_enabled() {
        
        // Arrange
        let expectedStreets = [
            Street(id: 1, title: "Street 1"),
            Street(id: 2, title: "Street 2")
        ]
        mockOrderService.responses.getStreets = .success(expectedStreets)
        
        // Act
        presenter.handleViewLoaded()
        
        // Assert
        
        // 1. loading indicator shown
        // 2. loading indicator dismissed
        let indicatorOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationSetIsAcitityIndicatorVisible($0)
        }
        XCTAssertEqual(indicatorOperations.count, 2, "Wrong amount of operations with acivity indicator")
        if indicatorOperations.count == 2 {
            XCTAssert(MockSelectAddresssView.isOperationSetIsAcitityIndicatorVisible(indicatorOperations[0],
                                                                                     withParam: true),
                      "Wrong operations with acivity indicator")
            XCTAssert(MockSelectAddresssView.isOperationSetIsAcitityIndicatorVisible(indicatorOperations[1],
                                                                                     withParam: false),
                      "Wrong operations with acivity indicator")
        }
        
        // 3. available streets set
        let streetsOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationSetAvailableStreets($0)
        }
        XCTAssertEqual(streetsOperations.count, 1, "Wrong amount of operations with available streets.")
        if streetsOperations.count == 1 {
            XCTAssert(MockSelectAddresssView.isOperationSetAvailableStreets(streetsOperations[0],
                                                                            withParam: expectedStreets),
                      "Incorrect available streets set.")
        }
        
        // 4. isEnabled
        let streetAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsStreetEnabled($0)
        }
        let buildingAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsBuildingEnabled($0)
        }
        let buttonAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsNextButtonEnabled($0)
        }
        
        XCTAssert(streetAvailabilityOperations.count > 0)
        if streetAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsStreetEnabled(streetAvailabilityOperations.last!,
                                                                        withParam: true),
                      "Street input is not enabled.")
        }
        XCTAssert(buildingAvailabilityOperations.count > 0)
        if buildingAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsBuildingEnabled(buildingAvailabilityOperations.last!,
                                                                          withParam: false),
                      "Building input is not disabled.")
        }
        XCTAssert(buttonAvailabilityOperations.count > 0)
        if buttonAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsNextButtonEnabled(buttonAvailabilityOperations.last!,
                                                                            withParam: false),
                      "Next button is not disabled.")
        }
    }
    
    func test_when_streets_loading_failed_then_error_is_shown() {
        
        // Arrange
        let expectedError = CommonError.serverCommunicationError(.noConnection)
        mockOrderService.responses.getStreets = .failure(expectedError)
        
        // Act
        presenter.handleViewLoaded()
        
        // Assert
        let errorOperations = mockView.recordedOperations.filter {
            if case .showTextForError(_) = $0 { return true }
            return false
        }
        XCTAssertEqual(errorOperations.count, 1, "Wrong amount of error alerts triggered.")
        if errorOperations.count == 1 {
            var isErrorAsExpected = false
            if case .showTextForError(.serverCommunicationError(.noConnection)) = errorOperations[0] {
                isErrorAsExpected = true
            }
            XCTAssert(isErrorAsExpected, "Wrong error was shown.")
        }
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
