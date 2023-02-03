//
//  ProductsListPagePresenter.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine

/// Present data to the product page view.
class ProductsPagePresenter: ObservableObject {
    @Published var loading: Bool = false
    @Published var products: [ProductItemPresentable] = []
    @Published var error: ErrorPresentable = ErrorPresentable.empty
    
    private var domainProducts: [Product] = []
    private var domainPromotions: [Promotion] = []
    
    private let loadProductsUseCase: LoadProductsUseCase
    private let loadPromotionsUseCase: LoadPromotionsUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(loadProductsUseCase: LoadProductsUseCase,
         loadPromotionsUseCase: LoadPromotionsUseCase) {
        self.loadProductsUseCase = loadProductsUseCase
        self.loadPromotionsUseCase = loadPromotionsUseCase
    }
    
    func load() {
        loading = true
        domainPromotions = loadPromotionsUseCase.execute()
        loadProductsUseCase.execute().sink { [weak self] completion in
            switch completion {
            case .failure:
                self?.error = ErrorPresentable(
                    title: "CabifyShop",
                    message: "We cannot load the products at this time."
                )
                break
            case .finished:
                self?.loading = false
                break
            }
        } receiveValue: { [weak self] domianProducts in
            let mapped = domianProducts.compactMap { product in
                return ProductItemPresentable.map(
                    product: product, promotions: self?.domainPromotions)
            }
            self?.products = mapped
            self?.domainProducts.removeAll()
            self?.domainProducts.append(contentsOf: domianProducts)
        }.store(in: &cancellables)
    }
}
