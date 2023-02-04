//
//  PromotionStrategiesRepository.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

import Foundation

struct PromotionStrategiesRepositoryImpl: PromotionStrategiesRepository {
    private let strategies: [Promotion.Code: PromotionStrategy] = [
        .twoForOne: TwoForOnePromotionStrategy(),
        .discount: DiscountForQuantityPromotionStrategy(
            activationQuantity: 3, promotedPrice: Decimal(19.00))
    ]

    func load() -> [Promotion.Code: PromotionStrategy] {
        strategies
    }
}
