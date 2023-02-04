//
//  AddProductToCartUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

struct AddProductToCartUseCase {
    let cartRepository: CartRepository
    
    func execute(product: Product) {
        var cartToUpdate = cartRepository.load()
        cartToUpdate.append(product)
        cartRepository.save(updatedCart: cartToUpdate)
    }
}
