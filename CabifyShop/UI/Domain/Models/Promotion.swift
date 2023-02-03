//
//  Promotion.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/02/2023.
//

import Foundation

struct Promotion {
    enum Code: String {
        case twoForOne = "2FOR1"
        case discount = "DISCOUNT"
        case empty = ""
    }

    let code: Code
    let productCodes: Set<ProductCode>
    let description: String

    static let empty = Promotion(
        code: .empty,
        productCodes: [],
        description: ""
    )
    
    init(code: Promotion.Code, productCodes: [ProductCode], description: String) {
        self.code = code
        self.productCodes = Set(productCodes)
        self.description = description
    }
    
    func isForProductCode(code: ProductCode) -> Bool {
        productCodes.contains(code)
    }
}
