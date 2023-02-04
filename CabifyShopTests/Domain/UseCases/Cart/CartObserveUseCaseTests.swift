//
//  CartObserveUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 01/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class CartObserveUseCaseTests: XCTestCase {
    func test_execute_gotNotification() {
        let repo = CartRepositoryMock()
        let sut = CartObserveUseCase(cartRepository: repo)
        
        repo.save(updatedCart: [product1])
        
        let exp = expectation(description: "wait for notification")
        let cancellable = sut.execute().sink { counter in
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancellable.cancel()
    }
}
