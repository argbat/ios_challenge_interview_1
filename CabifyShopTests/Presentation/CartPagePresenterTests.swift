//
//  CartPagePresenterTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class CartPagePresenterTests: XCTestCase {
    func test_load_emptyCart_showsEmpty() throws {
        let cartRepo = CartRepositoryMock()
        let loadCartUseCase = LoadCartUseCase(cartRepository: cartRepo)
        let cartObserveUseCase = CartObserveUseCase(cartRepository: cartRepo)
        let promosRepo = PromotionsRepositoryMock()
        let loadPromotionsUseCase = LoadPromotionsUseCase(
            promotionsRepository: promosRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase)
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        sut.$cart.sink { cartViewModel in
            XCTAssertTrue(cartViewModel.products.isEmpty)
            XCTAssertTrue(cartViewModel.showIsEmpty)
            exp.fulfill()
        }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_notEmptyCart_showNotEmpty() throws {
        let cartRepo = CartRepositoryMock()
        let loadCartUseCase = LoadCartUseCase(cartRepository: cartRepo)
        let cartObserveUseCase = CartObserveUseCase(cartRepository: cartRepo)
        let promosRepo = PromotionsRepositoryMock()
        let loadPromotionsUseCase = LoadPromotionsUseCase(
            promotionsRepository: promosRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase)
        cartRepo.save(updatedCart: [product1])
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        sut.$cart.sink { cartViewModel in
            XCTAssertFalse(cartViewModel.products.isEmpty)
            XCTAssertFalse(cartViewModel.showIsEmpty)
            exp.fulfill()
        }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_notEmptyCart_showsItemsInReverseOrder() throws {
        let cartRepo = CartRepositoryMock()
        let loadCartUseCase = LoadCartUseCase(cartRepository: cartRepo)
        let cartObserveUseCase = CartObserveUseCase(cartRepository: cartRepo)
        let promosRepo = PromotionsRepositoryMock()
        let loadPromotionsUseCase = LoadPromotionsUseCase(
            promotionsRepository: promosRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase)
        cartRepo.save(updatedCart: [product1, product2])
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        sut.$cart.sink { cartViewModel in
            XCTAssertEqual(cartViewModel.products.first?.code, product2.code)
            XCTAssertEqual(cartViewModel.products.last?.code, product1.code)
            exp.fulfill()
        }.store(in: &cancellables)
        waitForExpectations(timeout: 0.1)
    }
}
