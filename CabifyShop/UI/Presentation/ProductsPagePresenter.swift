//
//  ProductsListPagePresenter.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine

/// Present data to the product page view.
class ProductsPagePresenter: ObservableObject {
    @Published var products: [ProductItemPresentable] = []
    @Published var error: ErrorPresentable = ErrorPresentable.empty
    
    private var domainProducts: [Product] = []
    
    private let loadProductsUseCase: LoadProductsUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(loadProductsUseCase: LoadProductsUseCase) {
        self.loadProductsUseCase = loadProductsUseCase
    }
    
    func load() {
        loadProductsUseCase.execute().sink { [weak self] completion in
            switch completion {
            case .failure:
                self?.error = ErrorPresentable(
                    title: "CabifyShop",
                    message: "We cannot load the products at this time."
                )
                break
            case .finished:
                // do nothing
                break
            }
        } receiveValue: { [weak self] domianProducts in
            let mapped = domianProducts.compactMap { product in
                return ProductItemPresentable.map(product: product)
            }
            self?.products = mapped
            self?.domainProducts.removeAll()
            self?.domainProducts.append(contentsOf: domianProducts)
        }.store(in: &cancellables)
    }
}
