//
//  CartCalculatorUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 02/02/2023.
//

import XCTest

@testable import CabifyShop

final class CartCalculatorUseCaseTests: XCTestCase {
    func test_execute_emptyResult() throws {
        let repo = CartRepositoryMock()
        let promoRepo = PromotionsRepositoryMock()
        let strategiesRepo = PromotionStrategiesRepositoryMock()
        let sut = CartCalculatorUseCase(
            cartRepository: repo,
            promotionsRepository: promoRepo,
            promotionStrategiesRepository: strategiesRepo
        )
        
        let result = try XCTUnwrap(sut.execute())
        
        XCTAssertEqual(result.subtotal, Decimal(0))
        XCTAssertEqual(result.discounts, Decimal(0))
        XCTAssertEqual(result.total, Decimal(0))
        XCTAssertEqual(result.hasDiscounts, false)
    }
    
    func test_execute_invalid_getsNil() throws {
        let repo = CartRepositoryMock()
        let promoRepo = PromotionsRepositoryMock()
        let strategiesRepo = PromotionStrategiesRepositoryMock()
        let sut = CartCalculatorUseCase(
            cartRepository: repo,
            promotionsRepository: promoRepo,
            promotionStrategiesRepository: strategiesRepo
        )
        
        let result = try XCTUnwrap(sut.execute())
        
        XCTAssertEqual(result.subtotal, Decimal(0))
        XCTAssertEqual(result.discounts, Decimal(0))
        XCTAssertEqual(result.total, Decimal(0))
        XCTAssertEqual(result.hasDiscounts, false)
    }
    
    func test_execute_onlyOneProductWithNoPromotion_getsNoDiscounts() throws {
        let repo = CartRepositoryMock()
        repo.save(updatedCart: [productWithOutPromotion])
        let promoRepo = PromotionsRepositoryMock()
        let strategiesRepo = PromotionStrategiesRepositoryMock()
        let sut = CartCalculatorUseCase(
            cartRepository: repo,
            promotionsRepository: promoRepo,
            promotionStrategiesRepository: strategiesRepo
        )
        
        let result = try XCTUnwrap(sut.execute())
        
        XCTAssertEqual(result.subtotal, productWithOutPromotion.price)
        XCTAssertEqual(result.discounts, Decimal(0))
        XCTAssertEqual(result.total, productWithOutPromotion.price)
        XCTAssertEqual(result.hasDiscounts, false)
    }
    
    func test_execute_oneWithNoPromotionTwoWithPromotion_getsDiscounts() throws {
        let repo = CartRepositoryMock()
        repo.save(updatedCart: [productWithOutPromotion, product2, product2])
        let promoRepo = PromotionsRepositoryMock()
        let strategiesRepo = PromotionStrategiesRepositoryMock()
        let sut = CartCalculatorUseCase(
            cartRepository: repo,
            promotionsRepository: promoRepo,
            promotionStrategiesRepository: strategiesRepo
        )
        
        let result = try XCTUnwrap(sut.execute())
        
        XCTAssertEqual(result.subtotal,
                       productWithOutPromotion.price
                       + product2.price
                       + product2.price)
        XCTAssertEqual(result.discounts,
                       product2.price)
        XCTAssertEqual(result.total,
                       result.subtotal - result.discounts )
        XCTAssertEqual(result.hasDiscounts,
                       true)
    }
}
