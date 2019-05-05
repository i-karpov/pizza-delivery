//
//  menu_presenter_tests.swift
//  pizza-delivery-unit-tests
//
//  Created by Igor Karpov on 05.05.19.
//  Copyright © 2019 Igor Karpov. All rights reserved.
//

import XCTest
@testable import pizza_delivery

class menu_presenter_tests: XCTestCase {

    // MARK: - Properties
    
    private var mockNavigator: MockSceneNavigator!
    private var mockMenuService: MockMenuService!
    private var mockMenuView: MockMenuView!
    
    private var menuPresenter: MenuPresenterProtocol!
    
    private var nextPizzaId: Int!
    
    // MARK: - SetUp & TearDown
    
    override func setUp() {
        nextPizzaId = 1
        mockNavigator = MockSceneNavigator()
        mockMenuService = MockMenuService()
        mockMenuView = MockMenuView()
        
        menuPresenter = MenuPresenter(view: mockMenuView,
                                      navigator: mockNavigator,
                                      menuService: mockMenuService)
    }

    // MARK: - Tests
    
    func test_when_view_loaded_then_all_pizzas_get_loaded_with_indicator_and_then_shown() {
        
        // Arrange
        let expectedPizzas: [Pizza] = makePizzas(count: 10)
        mockMenuService.responses.getPizzas = .success(expectedPizzas)
        
        // Act
        menuPresenter.handleViewLoaded()
        
        // Assert
        XCTAssertEqual(mockMenuView.recordedOperations.count, 3, "Menu view was called wrong amount of times")
        
        var isIndicatorShownFirst = false
        var isIndicatorHiddenBeforeShowingResults = false
        var shownPizzas: [Pizza]? = .none
        
        if mockMenuView.recordedOperations.count >= 3 {
            if case .setIsAcitityIndicatorVisible(let isVisible) = mockMenuView.recordedOperations[0],
                isVisible == true {
                isIndicatorShownFirst = true
            }
            
            if case .setIsAcitityIndicatorVisible(let isVisible) = mockMenuView.recordedOperations[1],
                isVisible == false {
                isIndicatorHiddenBeforeShowingResults = true
            }
            
            if case .setPizzas(let pizzas) = mockMenuView.recordedOperations[2] {
                shownPizzas = pizzas
            }
        }
        
        XCTAssert(isIndicatorShownFirst, "Indicator was not shown first.")
        XCTAssert(isIndicatorHiddenBeforeShowingResults, "Indicator was not dismissed before showing results.")
        XCTAssertNotNil(shownPizzas, "Menu view have not received any pizzas.")
        XCTAssertEqual(shownPizzas?.count, expectedPizzas.count, "Menu view received wring amount of pizza")
    }

    func test_when_refresh_is_requested_after_data_has_changed_then_updated_pizzas_are_shown() {
        
        // Arrange
        let originalPizzas = makePizzas(count: 2)
        mockMenuService.responses.getPizzas = .success(originalPizzas)
        menuPresenter.handleViewLoaded()
        
        // Act
        var updatedPizzas = makePizzas(count: 3)
        mockMenuService.responses.getPizzas = .success(originalPizzas)
        menuPresenter.handleRefreshRequested()
        
        // Assert
        let setPizzasOperations = mockMenuView
            .recordedOperations
            .filter({ (operation) -> Bool in
                if case .setPizzas = operation {
                    return true
                }
                return false
            })

        var firstShownPizzasList: [Pizza]? = .none
        var secondShownPizzasList: [Pizza]? = .none
        if setPizzasOperations.count >= 2 {
            if case .setPizzas(let pizzas) = setPizzasOperations[0] {
                firstShownPizzasList = pizzas
            }
            if case .setPizzas(let pizzas) = setPizzasOperations[1] {
                secondShownPizzasList = pizzas
            }
        }
            
            
        XCTAssertEqual(setPizzasOperations.count, 2, "View recevied pizzas lists not exactly 2 times.")
        XCTAssertEqual(firstShownPizzasList?.count, originalPizzas.count, "First pizzas list received by view has incorrect count.")
        XCTAssertEqual(secondShownPizzasList?.count, updatedPizzas.count, "First pizzas list received by view has incorrect count.")
        for i in 0..<updatedPizzas.count {
            XCTAssertEqual(secondShownPizzasList?[i].id, updatedPizzas[i].id, "Pizza with index \(i) in second received list does not match expectation.")
        }
    }
    
    func test_when_error_on_initial_loading_then_error_with_retry_is_shown() {
        
        // Arrange
        mockMenuService.responses.getPizzas = .failure(.serverCommunicationError(.noConnection))
        
        // Act
        menuPresenter.handleViewLoaded()
        
        // Assert
        XCTAssertEqual(mockMenuView.recordedOperations.count, 3, "Menu view was called wrong amount of times")
    
        var isRetryProposed = false
        var shownError: CommonError? = .none
        var isShownErrorNoConnection = false
        
        // Ecpected: 2 calls for activity indicator and 1 for error
        if mockMenuView.recordedOperations.count >= 3 {
            if case .showTextWithRetryForError(let error) = mockMenuView.recordedOperations[2] {
                isRetryProposed = true
                shownError = error
                if case .serverCommunicationError(.noConnection) = error {
                    isShownErrorNoConnection = true
                }
            } else if case .showTextForError(let error) = mockMenuView.recordedOperations[2] {
                shownError = error
                if case .serverCommunicationError(.noConnection) = error {
                    isShownErrorNoConnection = true
                }
            }
        }
        
        XCTAssert(isRetryProposed, "Retry not proposed.")
        XCTAssertNotNil(shownError, "Error not shown.")
        XCTAssert(isShownErrorNoConnection, "Shown wrong error.")
    }
    
    func test_when_error_on_refresh_then_error_without_retry_is_shown() {
        // Arrange
        let originalPizzas = makePizzas(count: 10)
        mockMenuService.responses.getPizzas = .success(originalPizzas)
        menuPresenter.handleViewLoaded()
        mockMenuView.recordedOperations = []
        mockMenuService.responses.getPizzas = .failure(CommonError.unknown)
        
        // Act
        menuPresenter.handleRefreshRequested()
        
        // Assert
        XCTAssertEqual(mockMenuView.recordedOperations.count, 3, "Menu view was called wrong amount of times")
        
        var isRetryProposed = false
        var shownError: CommonError? = .none
        
        // Ecpected: 2 calls for activity indicator and 1 for error
        if mockMenuView.recordedOperations.count >= 3 {
            if case .showTextWithRetryForError(let error) = mockMenuView.recordedOperations[2] {
                isRetryProposed = true
                shownError = error
            } else if case .showTextForError(let error) = mockMenuView.recordedOperations[2] {
                shownError = error
            }
        }
        
        XCTAssertFalse(isRetryProposed, "Retry proposed.")
        XCTAssertNotNil(shownError, "Error not shown.")
    }

    func test_when_retried_and_no_errors_occured_then_pizzas_are_shown() {
        
        // Arrange
        mockMenuService.responses.getPizzas = .failure(.serverCommunicationError(.noConnection))
        menuPresenter.handleViewLoaded()
        let expectedPizzas = makePizzas(count: 5)
        mockMenuService.responses.getPizzas = .success(expectedPizzas)
        
        // Act
        menuPresenter.handleRetryTapped()
        
        // Assert
        XCTAssertEqual(mockMenuView.recordedOperations.count, 6, "Menu view was called wrong amount of times")
        
        var shownPizzas: [Pizza]? = .none
        
        if mockMenuView.recordedOperations.count >= 6 {
            if case .setPizzas(let pizzas) = mockMenuView.recordedOperations[5] {
                shownPizzas = pizzas
            }
        }
        
        XCTAssertNotNil(shownPizzas, "Menu view have not received any pizzas.")
        XCTAssertEqual(shownPizzas?.count, expectedPizzas.count, "Menu view received wring amount of pizza")
        if shownPizzas != nil && shownPizzas!.count == expectedPizzas.count {
            for i in 0..<shownPizzas!.count {
                XCTAssertEqual(shownPizzas![i].id, expectedPizzas[i].id, "Pizza with index \(i) does not match expectation.")
            }
        }
    }
    
    func test_when_user_tapped_order_then_order_flow_starts() {
        
        // Arrange
        let pizzas: [Pizza] = makePizzas(count: 5)
        let expectedPizza = pizzas[2]
        mockMenuService.responses.getPizzas = .success(pizzas)
        menuPresenter.handleViewLoaded()
        
        // Act
        menuPresenter.handleOrderPizzaTapped(pizza: expectedPizza)
        
        // Assert
        XCTAssertEqual(mockNavigator.recordedOperations.count, 1, "Wrong number of calls to navigator.")
        
        var orderedPizza: Pizza? = .none
        if mockNavigator.recordedOperations.count >= 1 {
            if case .startFlow(let flow, _) = mockNavigator.recordedOperations[0] {
                if case .order(let orderFlowInitData) = flow {
                    orderedPizza = orderFlowInitData.pizza
                }
            }
        }
        
        XCTAssertNotNil(orderedPizza, "Order pizza flow was not started.")
        XCTAssertEqual(orderedPizza?.id, expectedPizza.id, "Wrong pizza was ordered (wrong id)")
        XCTAssertEqual(orderedPizza?.title, expectedPizza.title, "Wrong pizza was ordered (wrong title)")
        XCTAssertEqual(orderedPizza?.price.cents, expectedPizza.price.cents, "Wrong pizza was ordered (wrong price)")
        XCTAssertEqual(orderedPizza?.description, expectedPizza.description, "Wrong pizza was ordered (description)")
    }
    
    // MARK: - Helpers
    
    private func makePizzas(count: Int) -> [Pizza] {
        guard count > 0 else {
            return []
        }
        
        return (1...count).map { (id) in
            let pizza = Pizza(
                id: nextPizzaId,
                title: "Pizza \(id)",
                price: Price(cents: id * 1000),
                description: "Description \(id)",
                smallImageUrl: "Url \(id)"
            )
            nextPizzaId += 1
            return pizza
        }
    }
}
