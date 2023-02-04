//
//  CartObserveUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine

/// Let observe changes on the cart.
class CartObserveUseCase {
    private let cartRepository: CartRepository
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute() -> AnyPublisher<[Product], Never> {
        cartRepository.didSave
            .eraseToAnyPublisher()
    }
}
