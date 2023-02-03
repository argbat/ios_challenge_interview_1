//
//  CabifyLoadProductsUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

struct LoadPromotionsUseCase {
    let promotionsRepository: PromotionsRepository
    
    func execute() -> [Promotion] {
        promotionsRepository.load()
    }
}
