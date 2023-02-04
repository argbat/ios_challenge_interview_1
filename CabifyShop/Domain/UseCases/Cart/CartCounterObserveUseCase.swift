//
//  CartCounterObserveUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine

class CartCounterObserveUseCase {
    private let cartRepository: CartRepository
    private var cancelables: Set<AnyCancellable> = []
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute() -> AnyPublisher<UInt, Never> {
        cartRepository.didSave
            .map { productsInCart in
                UInt(productsInCart.count)
            }
            .eraseToAnyPublisher()
    }
}
