//
//  RemoveProductFromCartUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 01/02/2023.
//

import XCTest

@testable import CabifyShop

final class RemoveProductFromCartUseCaseTests: XCTestCase {
    func test_execute_empty_doesNotRemoveNothing() {
        let repo = CartRepositoryMock()
        let sut = RemoveProductFromCartUseCase(cartRepository: repo)
        
        XCTAssertEqual(repo.cart.count, 0)
        
        sut.execute(productIdx: 0)
        
        XCTAssertEqual(repo.cart.count, 0)
    }
    
    func test_execute_invalidIdxOnNotEmptyRepo_DoesNotRemoveNothing() {
        let repo = CartRepositoryMock()
        repo.save(updatedCart: [product1])

        let sut = RemoveProductFromCartUseCase(cartRepository: repo)
        
        XCTAssertEqual(repo.cart.count, 1)
        
        sut.execute(productIdx: 1)
        
        XCTAssertEqual(repo.cart.count, 1)
    }
    
    func test_execute_validIdx_removesItem() {
        let repo = CartRepositoryMock()
        repo.save(updatedCart: [product1])

        let sut = RemoveProductFromCartUseCase(cartRepository: repo)
        
        XCTAssertEqual(repo.cart.count, 1)
        
        sut.execute(productIdx: 0)
        
        XCTAssertEqual(repo.cart.count, 0)
    }
}
