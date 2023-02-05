//
//  AddProductToCartUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

class AddProductToCartUseCase {
    private let cartRepository: CartRepository
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute(product: Product) {
        var cartToUpdate = cartRepository.load()
        cartToUpdate.append(product)
        cartRepository.save(updatedCart: cartToUpdate)
    }
}
