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
    
// MARK: - Presenters
    func makeProductsPagePresenter() -> ProductsPagePresenter {
        ProductsPagePresenter(
            loadProductsUseCase: makeLoadProductsUseCase(),
            loadPromotionsUseCase: makeLoadPromotionsUseCase()
        )
    }
}
