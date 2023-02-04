//
//  MainPagePresenterTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

class MainPagePresenterTests: XCTestCase {
    func test_observeUpdates_updatesBadgeCounter() {
        let cartRepo = CartRepositoryMock()
        let cartCounterObserverUseCase = CartCounterObserveUseCase(cartRepository: cartRepo)
        
        let sut = MainPagePresenter(cartCounterObserveUseCase: cartCounterObserverUseCase)
        sut.observeUpdates()
        cartRepo.save(updatedCart: [product1])
        
        let exp = expectation(description: "wait for notification")
        let cancelable = sut.$mainPage.sink { mainPage in
            XCTAssertEqual(mainPage.cartBadgeValue, 1)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
}
