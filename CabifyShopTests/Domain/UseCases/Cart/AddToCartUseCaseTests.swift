//
//  AddToCartUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 01/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class AddToCartUseCaseTests: XCTestCase {
    func test_execute_productAddToEmptyCart_oneProductInCart() {
        let repo = CartRepositoryMock()
        let sut = AddProductToCartUseCase(cartRepository: repo)
        
        sut.execute(product: product1)
        
        XCTAssertEqual(repo.cart.count, 1)
    }
    
    func test_execute_productAddToNonEmptyCart_moreThanProductInCart() {
        let repo = CartRepositoryMock()
        let sut = AddProductToCartUseCase(cartRepository: repo)
        
        sut.execute(product: product1)
        
        sut.execute(product: product2)

        XCTAssertEqual(repo.cart.count, 2)
    }
    
    func test_execute_productAddAlreadyExisitingProduct_allowsDuplicates() {
        let repo = CartRepositoryMock()
        let sut = AddProductToCartUseCase(cartRepository: repo)
        
        sut.execute(product: product1)
        sut.execute(product: product1)
        
        XCTAssertEqual(repo.cart.count, 2)
    }
}
