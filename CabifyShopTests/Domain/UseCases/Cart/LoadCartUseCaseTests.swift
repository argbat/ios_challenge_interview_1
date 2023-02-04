//
//  LoadCartUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 01/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class LoadCartUseCaseTests: XCTestCase {
    func test_execute_emptyResult() {
        let repo = CartRepositoryMock()
        let sut = LoadCartUseCase(cartRepository: repo)
        
        let cart = sut.execute()
        
        XCTAssertEqual(cart.isEmpty, true)
    }
    
    func test_execute_notEmptyResult() {
        let repo = CartRepositoryMock()
        repo.save(updatedCart: [product1])
        let sut = LoadCartUseCase(cartRepository: repo)
        
        let cart = sut.execute()
        
        XCTAssertEqual(cart.isEmpty, false)

    }
}
