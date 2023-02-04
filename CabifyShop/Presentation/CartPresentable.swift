//
//  CartPresentable.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

/// Holds representable data for products in cart.
struct CartPresentable {
    let products: [ProductItemPresentable]
    let showIsEmpty: Bool

    /// Maps a product to a cart presentable model.
    ///
    ///  - Returns an instance with representable or nil if mapping fails.
    static func map(products: [Product], promotions: [Promotion]) -> CartPresentable? {
        let productItemsViewModel = products.compactMap { product in
            return ProductItemPresentable.map(product: product, promotions: promotions)
        }
        let showIsEmpty = products.isEmpty
        return CartPresentable(
            products: productItemsViewModel,
            showIsEmpty: showIsEmpty)
    }
    
    static let empty = CartPresentable(products: [], showIsEmpty: true)
}
