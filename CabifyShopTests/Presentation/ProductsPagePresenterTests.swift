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
        let promoRepo = PromotionsRepositoryMock()
        let cartRepo = CartRepositoryMock()
        
        let loadProductsUseCase = LoadProductsUseCase(productsRepository: productsRepo)
        let loadPromotionsUseCase = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        let addToCartUseCase = AddProductToCartUseCase(cartRepository: cartRepo)
        
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase,
            loadPromotionsUseCase: loadPromotionsUseCase,
            addProductToCartUseCase: addToCartUseCase
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
        let promoRepo = PromotionsRepositoryMock()
        let cartRepo = CartRepositoryMock()
        
        let loadProductsUseCase = LoadProductsUseCase(productsRepository: productsRepo)
        let loadPromotionsUseCase = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        let addToCartUseCase = AddProductToCartUseCase(cartRepository: cartRepo)
        
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase,
            loadPromotionsUseCase: loadPromotionsUseCase,
            addProductToCartUseCase: addToCartUseCase
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
        let promoRepo = PromotionsRepositoryMock()
        let cartRepo = CartRepositoryMock()
        
        let loadProductsUseCase = LoadProductsUseCase(productsRepository: productsRepo)
        let loadPromotionsUseCase = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        let addToCartUseCase = AddProductToCartUseCase(cartRepository: cartRepo)
        
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase,
            loadPromotionsUseCase: loadPromotionsUseCase,
            addProductToCartUseCase: addToCartUseCase
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
    
    func test_addToCart_oneAddedToEmptyCart() {
        let productsRepo = NotEmptyLoadProductsRepositoryMock()
        let promoRepo = PromotionsRepositoryMock()
        let cartRepo = CartRepositoryMock()
        
        let loadProductsUseCase = LoadProductsUseCase(productsRepository: productsRepo)
        let loadPromotionsUseCase = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        let addToCartUseCase = AddProductToCartUseCase(cartRepository: cartRepo)
        
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase,
            loadPromotionsUseCase: loadPromotionsUseCase,
            addProductToCartUseCase: addToCartUseCase
        )
        
        sut.load()

        XCTAssertEqual(cartRepo.cart.count, 0)
        
        sut.addToCart(
            product: ProductItemPresentable.map(
                product: product1,
                promotions: [promotionProduct1Code, promotionProduct2Code]
            )!)
        
        XCTAssertEqual(cartRepo.cart.count, 1)
    }
    
    func test_addToCart_oneAddedToNotEmptyCart() {
        let productsRepo = NotEmptyLoadProductsRepositoryMock()
        let promoRepo = PromotionsRepositoryMock()
        let cartRepo = CartRepositoryMock()
        
        let loadProductsUseCase = LoadProductsUseCase(productsRepository: productsRepo)
        let loadPromotionsUseCase = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        let addToCartUseCase = AddProductToCartUseCase(cartRepository: cartRepo)
        
        let sut = ProductsPagePresenter(
            loadProductsUseCase: loadProductsUseCase,
            loadPromotionsUseCase: loadPromotionsUseCase,
            addProductToCartUseCase: addToCartUseCase
        )
        
        sut.load()
        cartRepo.save(updatedCart: [product1])
        
        sut.addToCart(
            product: ProductItemPresentable.map(
                product: product1,
                promotions: [promotionProduct1Code, promotionProduct2Code])!)
        
        XCTAssertEqual(cartRepo.cart.count, 2)
    }
}
