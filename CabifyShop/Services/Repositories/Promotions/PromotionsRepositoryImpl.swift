//
//  PromotionsRepositoryImpl.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/02/2023.
//

import Foundation

class PromotionsRepositoryImpl: PromotionsRepository {
    private let repo: [Promotion] = [
        Promotion(
            code: .discount,
            productCodes: ["TSHIRT"],
            description: "3 or more, pay $19.00 each."
        ),
        Promotion(
            code: .twoForOne,
            productCodes: ["VOUCHER"],
            description: "2For1 on this item."
        ),
    ]
    
    func load() -> [Promotion] {
        repo
    }
}
