//
//  ProductsPagePresenter.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

class ProductsPagePresenterTests: XCTestCase {
    func test_load_error() {
        let productsRepo = ErrorLoadProductsRepositoryMock(error: .UnableToLoad)
        let loadProductsUseCase = LoadProductsUseCase(
            productsRepository: productsRepo
        )
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase
        )
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        sut.$error.sink { error in
            XCTAssertEqual(error.title, "CabifyShop")
            XCTAssertEqual(error.message, "We cannot load the products at this time.")
            exp.fulfill()
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_notEmpty() {
        let productsRepo = NotEmptyLoadProductsRepositoryMock()
        let loadProductsUseCase = LoadProductsUseCase(
            productsRepository: productsRepo
        )
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase
        )
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        // TODO i want to not call dropFirst, just call sink.
        sut.$products.sink { products in
            XCTAssertFalse(products.isEmpty)
            exp.fulfill()
        }.store(in: &cancellables)
        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_empty() {
        let productsRepo = EmptyLoadProductsRepositoryMock()
        let loadProductsUseCase = LoadProductsUseCase(
            productsRepository: productsRepo
        )
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase
        )
        
        sut.load()
        
        let exp = expectation(description: "wait for load")
        var cancellables: Set<AnyCancellable> = []
        // TODO i want to not call dropFirst, just call sink.
        sut.$products.sink { products in
            XCTAssertTrue(products.isEmpty)
            exp.fulfill()
        }.store(in: &cancellables)
        waitForExpectations(timeout: 0.1)
    }
}
