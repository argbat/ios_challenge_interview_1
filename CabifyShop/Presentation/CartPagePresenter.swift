//
//  CartPagePresenter.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine
import Foundation

/// Present data to the cart page view.
class CartPagePresenter: ObservableObject {
    @Published var cart: CartPresentable = CartPresentable.empty
    
    private var domainProducts: [Product] = []
    private var domainPromotions: [Promotion] = []

    private let loadCartUseCase: LoadCartUseCase
    private let loadPromotionsUseCase: LoadPromotionsUseCase
    private let cartObserveUseCase: CartObserveUseCase
    private let removeProductFromCartUseCase: RemoveProductFromCartUseCase

    private var cancellables: Set<AnyCancellable> = []

    init(loadCartUseCase: LoadCartUseCase,
         loadPromotionsUseCase: LoadPromotionsUseCase,
         cartObserveUseCase: CartObserveUseCase,
         removeProductFromCartUseCase: RemoveProductFromCartUseCase) {
        self.loadCartUseCase = loadCartUseCase
        self.loadPromotionsUseCase = loadPromotionsUseCase
        self.cartObserveUseCase = cartObserveUseCase
        self.removeProductFromCartUseCase = removeProductFromCartUseCase
    
        self.cartObserveUseCase.execute().sink { [weak self] productsInCart in
            guard let self = self else { return }
            self.domainProducts = productsInCart
            self.cart = self.mapToCart()
        }.store(in: &cancellables)
    }
    
    func load() {
        domainPromotions = loadPromotionsUseCase.execute()
        domainProducts = loadCartUseCase.execute()
        cart = mapToCart()
    }
    
    func removeProduct(product: ProductItemPresentable) {
        let idx = cart.products.firstIndex { $0.id == product.id }
        guard let idx = idx else {
            return
        }
        removeProductFromCartUseCase.execute(productIdx: UInt(idx))
    }

    private func mapToCart() -> CartPresentable {
        return CartPresentable.map(products: domainProducts.reversed(),
                                   promotions: domainPromotions) ?? CartPresentable.empty
    }
}
