//
//  LoadProductsUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class LoadProductsUseCaseTests: XCTestCase {
    func test_execute_emptyResult() {
        let repo = EmptyLoadProductsRepositoryMock()
        let sut = LoadProductsUseCase(
            productsRepository: repo
        )
        
        let exp = expectation(description: "wait for load products use case")
        let cancelable = sut.execute().sink { error in
            XCTFail()
            exp.fulfill()
        } receiveValue: { products in
            XCTAssertEqual(products.isEmpty, true)
            exp.fulfill()
        }

        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
    
    func test_execute_notEmptyResult() {
        let repo = NotEmptyLoadProductsRepositoryMock()
        let sut = LoadProductsUseCase(
            productsRepository: repo
        )
        
        let exp = expectation(description: "wait for load products use case")
        let cancelable = sut.execute().sink { error in
            XCTFail()
            exp.fulfill()
        } receiveValue: { products in
            XCTAssertEqual(products.isEmpty, false)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
    
    func test_execute_unableToLoadProducts_reasonRepositoryError() {
        let repo = ErrorLoadProductsRepositoryMock(error: .UnableToLoad)
        let sut = LoadProductsUseCase(
            productsRepository: repo
        )
        
        let exp = expectation(description: "wait for load products use case")
        let cancelable = sut.execute().sink { error in
            exp.fulfill()
        } receiveValue: { products in
            XCTFail()
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
}
