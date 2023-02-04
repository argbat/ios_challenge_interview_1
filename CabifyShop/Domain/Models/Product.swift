//
//  Product.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Foundation

typealias ProductCode = String

/// Represent a product ready to use by the app.
///
/// Two products are equal if the holds the same code.
struct Product: Hashable {
    let code: ProductCode
    let name: String
    let price: Decimal
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.code == rhs.code
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}
