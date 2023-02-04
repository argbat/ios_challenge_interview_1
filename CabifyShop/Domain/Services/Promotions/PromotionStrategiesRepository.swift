//
//  PromotionStrategiesRepository.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

protocol PromotionStrategiesRepository {
    func load() -> [Promotion.Code: PromotionStrategy]
}
