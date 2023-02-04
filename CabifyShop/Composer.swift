//
//  Composer.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Foundation

/// Compose objects with required dependencies.
struct Composer {
    static let productsApi: ProductsApi = ProductsApiImpl(
        // TODO add env specific properties using targets and plists.
        baseUrl: "https://gist.githubusercontent.com/",
        session: URLSession.shared
    )
    static let productsRepo: ProductsRepository = ProductsRepositoryImpl(
        api: Composer.productsApi
    )
    static let promotionsRepo: PromotionsRepository = PromotionsRepositoryImpl()
    static let cartRepo: CartRepository = CartRepositoryImpl()
    
// MARK: - Use Cases
    func makeLoadProductsUseCase() -> LoadProductsUseCase {
        LoadProductsUseCase(
            productsRepository: Composer.productsRepo
        )
    }
    
    func makeLoadPromotionsUseCase() -> LoadPromotionsUseCase {
        LoadPromotionsUseCase(
            promotionsRepository: Composer.promotionsRepo
        )
    }
    
    func makeLoadCartUseCase() -> LoadCartUseCase {
        LoadCartUseCase(cartRepository: Composer.cartRepo)
    }
    
    func makeCartObserveUseCase() -> CartObserveUseCase {
        CartObserveUseCase(
            cartRepository: Composer.cartRepo
        )
    }
    
    func makeAddProductToCartUseCase() -> AddProductToCartUseCase {
        AddProductToCartUseCase(cartRepository: Composer.cartRepo)
    }
    
    func makeCartCounterObserveUseCase() -> CartCounterObserveUseCase {
        CartCounterObserveUseCase(cartRepository: Composer.cartRepo)
    }
    
// MARK: - Presenters
    func makeMainPagePresenter() -> MainPagePresenter {
        MainPagePresenter(cartCounterObserveUseCase: makeCartCounterObserveUseCase())
    }

    func makeProductsPagePresenter() -> ProductsPagePresenter {
        ProductsPagePresenter(
            loadProductsUseCase: makeLoadProductsUseCase(),
            loadPromotionsUseCase: makeLoadPromotionsUseCase(),
            addProductToCartUseCase: makeAddProductToCartUseCase()
        )
    }
    
    func makeCartPagePresenter() -> CartPagePresenter {
        CartPagePresenter(
            loadCartUseCase: makeLoadCartUseCase(),
            loadPromotionsUseCase: makeLoadPromotionsUseCase(),
            cartObserveUseCase: makeCartObserveUseCase()
        )
    }
}
