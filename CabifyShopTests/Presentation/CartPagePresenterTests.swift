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
        let removeProductFromCartUseCase = RemoveProductFromCartUseCase(cartRepository: cartRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase,
                                    removeProductFromCartUseCase: removeProductFromCartUseCase)
        
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
        let removeProductFromCartUseCase = RemoveProductFromCartUseCase(cartRepository: cartRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase,
                                    removeProductFromCartUseCase: removeProductFromCartUseCase)

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
        let removeProductFromCartUseCase = RemoveProductFromCartUseCase(cartRepository: cartRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase,
                                    removeProductFromCartUseCase: removeProductFromCartUseCase)

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
    
    func test_remove_existingProductInCart_remmovesIt() throws {
        let cartRepo = CartRepositoryMock()
        let loadCartUseCase = LoadCartUseCase(cartRepository: cartRepo)
        let cartObserveUseCase = CartObserveUseCase(cartRepository: cartRepo)
        let removeProductFromCartUseCase = RemoveProductFromCartUseCase(cartRepository: cartRepo)
        let promosRepo = PromotionsRepositoryMock()
        let loadPromotionsUseCase = LoadPromotionsUseCase(
            promotionsRepository: promosRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase,
                                    removeProductFromCartUseCase: removeProductFromCartUseCase)
        
        cartRepo.save(updatedCart: [product1])
        sut.load()
        
        var exp = expectation(description: "wait for load")
        var productInCart: ProductItemPresentable?
        var cancellable = sut.$cart.sink { cartViewModel in
            productInCart = cartViewModel.products.first
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
        
        sut.removeProduct(product: try XCTUnwrap(productInCart))
        
        exp = expectation(description: "wait for remove")
        cancellable = sut.$cart.sink { cartViewModel in
            XCTAssertTrue(cartViewModel.products.isEmpty)
            XCTAssertTrue(cartViewModel.showIsEmpty)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }

    func test_remove_notExistingProductInCart_doesNothing() throws {
        let cartRepo = CartRepositoryMock()
        let loadCartUseCase = LoadCartUseCase(cartRepository: cartRepo)
        let cartObserveUseCase = CartObserveUseCase(cartRepository: cartRepo)
        let removeProductFromCartUseCase = RemoveProductFromCartUseCase(cartRepository: cartRepo)
        let promosRepo = PromotionsRepositoryMock()
        let loadPromotionsUseCase = LoadPromotionsUseCase(
            promotionsRepository: promosRepo)
        let sut = CartPagePresenter(loadCartUseCase: loadCartUseCase,
                                    loadPromotionsUseCase: loadPromotionsUseCase,
                                    cartObserveUseCase: cartObserveUseCase,
                                    removeProductFromCartUseCase: removeProductFromCartUseCase)
        
        cartRepo.save(updatedCart: [product1])
        sut.load()
        
        sut.removeProduct(
            product: ProductItemPresentable(
                code: "code",
                name: "name",
                promotion: "",
                showPromotion: false,
                price: "$1.00"
            )
        )
        
        let exp = expectation(description: "wait for remove")
        let cancellable = sut.$cart.sink { cartViewModel in
            XCTAssertFalse(cartViewModel.products.isEmpty)
            XCTAssertFalse(cartViewModel.showIsEmpty)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
}
