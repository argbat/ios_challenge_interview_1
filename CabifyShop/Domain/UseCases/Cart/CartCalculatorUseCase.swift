//
//  CartCalculatorUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

import Foundation

/// Calculate cart totals.
class CartCalculatorUseCase {
    private let cartRepository: CartRepository
    private let promotionsRepository: PromotionsRepository
    private let promotionStrategiesRepository: PromotionStrategiesRepository

    init(cartRepository: CartRepository,
         promotionsRepository: PromotionsRepository,
         promotionStrategiesRepository: PromotionStrategiesRepository) {
        self.cartRepository = cartRepository
        self.promotionsRepository = promotionsRepository
        self.promotionStrategiesRepository = promotionStrategiesRepository
    }

    /// - Returns an instance of calculator result or nil if not result was able to be calculated.
    func execute() -> CartCalculatorResult? {
        let cart = cartRepository.load()
        let promos = promotionsRepository.load()
        let productsPromotion = cart.reduce(into: [:]) { partialResult, product in
            let productPromo = promos.first { $0.isForProductCode(code: product.code) }
            partialResult[product] = productPromo ?? Promotion.empty
        }
        guard let productsPromotion = productsPromotion as? [Product: Promotion] else {
            return CartCalculatorResult.empty
        }
        let calculatorItems = cart.reduce(into: [:]) { partialResult, product in
            partialResult[product, default: UInt(0)] += UInt(1)
        }
        let strategies = promotionStrategiesRepository.load()
        let withOutDiscountsTotalCalculator = CartTotalCalculator(
            strategyBuilder: { _ in NoPromotionStrategy() })
        let withDiscountsTotalCalculator = CartTotalCalculator(
            strategyBuilder: { promotionCode in
            strategies[promotionCode] ?? NoPromotionStrategy()})
        
        guard let withOutDiscountsTotal = try? withOutDiscountsTotalCalculator.execute(calculatorItems: calculatorItems, productsPromotion: productsPromotion),
              let withDiscountsTotal = try? withDiscountsTotalCalculator.execute(calculatorItems: calculatorItems, productsPromotion: productsPromotion) else {
            // TODO Log a reason
            return nil
        }

        return CartCalculatorResult(
            subtotal: withOutDiscountsTotal,
            discounts: withOutDiscountsTotal - withDiscountsTotal,
            total: withDiscountsTotal)
    }
}
