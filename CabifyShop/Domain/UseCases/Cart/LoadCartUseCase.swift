//
//  LoadCartUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine
import Foundation

class LoadCartUseCase {
    private let cartRepository: CartRepository
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute() -> [Product] {
        return cartRepository.load()
    }
}
