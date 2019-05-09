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
    
    private var isCloseInitiated: Bool?
    private var returnedOutput: SelectAddressInitData.SelectAddressSceneOutput?
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        mockNavigator = MockSceneNavigator()
        mockOrderService = MockOrderService()
        mockView = MockSelectAddresssView()
        
        isCloseInitiated = .none
        returnedOutput = .none
        
        let initData = SelectAddressInitData(
            handleCloseTapped: { [weak self] in
                self?.isCloseInitiated = true
        },
            handleEnteringFinished: { [weak self] (streetAndBuilding) in
                self?.returnedOutput = streetAndBuilding
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
        
        // Arrange

        // Act
        presenter.handleErrorDismissed()
        
        // Assert
        
        XCTAssert(isCloseInitiated ?? false, "Not closed after error dismissed.")
    }
    
    func test_when_steet_picked_then_buildings_get_loaded_for_this_street() {
        
        // Arrange
        mockOrderService.responses.getStreets = .success([])
        let expectedBuildings = [Building(id: 1, title: "B 1"), Building(id: 2, title: "B 2")]
        mockOrderService.responses.getBuildings = .success(expectedBuildings)
        presenter.handleViewLoaded()
        mockView.recordedOperations.removeAll {
            MockSelectAddresssView.isOperationSetIsAcitityIndicatorVisible($0)
        }
        
        // Act
        let expectedStreetId = 12
        presenter.handleStreetValueChanged(Street(id: expectedStreetId, title: "Some title"))
        
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
        
        // 3. available buildings set
        let buildingsOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationSetAvailableBuildings($0)
        }
        XCTAssertEqual(buildingsOperations.count, 1, "Wrong amount of operations with available builidings.")
        if buildingsOperations.count == 1 {
            XCTAssert(MockSelectAddresssView.isOperationSetAvailableBuildings(buildingsOperations[0],
                                                                              withParam: expectedBuildings),
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
                                                                          withParam: true),
                      "Building input is not enabled.")
        }
        XCTAssert(buttonAvailabilityOperations.count > 0)
        if buttonAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsNextButtonEnabled(buttonAvailabilityOperations.last!,
                                                                            withParam: false),
                      "Next button is not disabled.")
        }
        
        var requestedStreetId: Int? = .none
        let buildingsRequestOperations = mockOrderService.recordedOperations.filter {
            if case .getBuildings(let streetId) = $0 {
                requestedStreetId = streetId
                return true
            }
            return false
        }
        XCTAssertEqual(buildingsRequestOperations.count, 1, "Wrong amount of operations with buildings.")
        if buildingsRequestOperations.count == 1 {
            XCTAssertNotNil(requestedStreetId)
            if let requestedStreetId = requestedStreetId {
                XCTAssertEqual(requestedStreetId, expectedStreetId, "Buildings requested with worng street id.")
            }
            
        }
    }
    
    func test_when_steet_changed_then_building_is_erased_and_next_button_is_disabled() {
        
        // Arrange
        
        mockOrderService.responses.getStreets = .success([])
        mockOrderService.responses.getBuildings = .success([])
        presenter.handleViewLoaded()
        presenter.handleStreetValueChanged(Street(id: 1, title: "1"))
        presenter.handleBuildingValueChanged(Building(id: 1, title: "1"))
        mockView.recordedOperations = []
        
        // Act
        
        presenter.handleStreetValueChanged(Street(id: 2, title: "2"))
        
        // Assert
        
        let erasingOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationEraseBuilding($0)
        }
        XCTAssert(erasingOperations.count > 0, "Building input was not erased.")
        
        let buttonAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsNextButtonEnabled($0)
        }
        XCTAssert(buttonAvailabilityOperations.count > 0)
        if buttonAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsNextButtonEnabled(buttonAvailabilityOperations.last!,
                                                                            withParam: false),
                      "Next button is not disabled.")
        }
    }
    
    func test_when_building_picked_then_next_button_becomes_enabled() {
        
        // Arrange
        
        mockOrderService.responses.getStreets = .success([])
        mockOrderService.responses.getBuildings = .success([])
        presenter.handleViewLoaded()
        presenter.handleStreetValueChanged(Street(id: 1, title: "1"))
        
        
        // Act
        
        presenter.handleBuildingValueChanged(Building(id: 1, title: "1"))
        
        // Assert

        let buttonAvailabilityOperations = mockView.recordedOperations.filter {
            MockSelectAddresssView.isOperationIsNextButtonEnabled($0)
        }
        XCTAssert(buttonAvailabilityOperations.count > 0)
        if buttonAvailabilityOperations.count > 0 {
            XCTAssert(MockSelectAddresssView.isOperationIsNextButtonEnabled(buttonAvailabilityOperations.last!,
                                                                            withParam: true),
                      "Next button is not enabled.")
        }
    }
    
    func test_when_address_picked_and_next_tapped_then_scene_returns_entered_address() {
        
        // Arrange
        
        mockOrderService.responses.getStreets = .success([])
        mockOrderService.responses.getBuildings = .success([])
        presenter.handleViewLoaded()
        let expectedStreet = Street(id: 1, title: "1")
        let expectedBuilding = Building(id: 2, title: "2")
        presenter.handleStreetValueChanged(expectedStreet)
        presenter.handleBuildingValueChanged(expectedBuilding)
        
        // Act
        
        presenter.handleNextTapped()
        
        // Assert
        
        XCTAssertNotNil(returnedOutput, "Address was not returned.")
        if let returnedOutput = returnedOutput {
            XCTAssertEqual(returnedOutput.street, expectedStreet, "Returned street do not match.")
            XCTAssertEqual(returnedOutput.buidling, expectedBuilding, "Returned building do not match.")
        }
    }
    
    func test_when_address_picked_and_updated_and_next_tapped_then_scene_returns_updated_address() {
        // Arrange
        
        mockOrderService.responses.getStreets = .success([])
        mockOrderService.responses.getBuildings = .success([])
        presenter.handleViewLoaded()
        
        presenter.handleStreetValueChanged(Street(id: 1, title: "1"))
        presenter.handleBuildingValueChanged(Building(id: 2, title: "2"))
        
        // Act
        
        let expectedStreet = Street(id: 101, title: "101")
        let expectedBuilding = Building(id: 201, title: "201")
        presenter.handleStreetValueChanged(expectedStreet)
        presenter.handleBuildingValueChanged(expectedBuilding)
        presenter.handleNextTapped()
        
        // Assert
        
        XCTAssertNotNil(returnedOutput, "Address was not returned.")
        if let returnedOutput = returnedOutput {
            XCTAssertEqual(returnedOutput.street, expectedStreet, "Returned street do not match.")
            XCTAssertEqual(returnedOutput.buidling, expectedBuilding, "Returned building do not match.")
        }
    }
}
