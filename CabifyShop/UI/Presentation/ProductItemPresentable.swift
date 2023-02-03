//
//  ProductItemPresentable.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Foundation

/// Holds representable data for a  product on a list.
struct ProductItemPresentable: Identifiable {
    let id: String = UUID().uuidString
    let code: String
    let name: String
    let promotion: String
    let showPromotion: Bool
    let price: String
    
    
    /// Maps a product to a view repesentable card.
    ///
    /// - Returns an instance of representable or nil if mapping fails.
    static func map(product: Product) -> ProductItemPresentable? {
        let priceFormatter = NumberFormatter()
        
        guard let formattedPrice = priceFormatter.priceFormatter(price: product.price) else {
            return nil
        }
        
        return ProductItemPresentable(code: product.code,
                                      name: product.name,
                                      promotion: "",
                                      showPromotion: false,
                                      price: formattedPrice)
    }
}
