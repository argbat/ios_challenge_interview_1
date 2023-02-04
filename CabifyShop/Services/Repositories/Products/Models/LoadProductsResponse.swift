//
//  LoadProductsResponse.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Foundation

/// Represent a load response data from the backend
struct LoadProductsResponse: Decodable {
    let products: [ProductResponse]
    
    func map() -> [Product]? {
        products.compactMap { $0.map() }
    }
}

/// Represent a backend product data
struct ProductResponse: Decodable {
    let code: String
    let name: String
    let price: Double
    
    func map() -> Product {
        return Product(
            code: self.code,
            name: self.name,
            price: Decimal(price)
        )
    }
}
