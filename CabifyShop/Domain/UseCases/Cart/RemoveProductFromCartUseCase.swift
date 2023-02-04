//
//  RemoveProductFromCartUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

struct RemoveProductFromCartUseCase {
    let cartRepository: CartRepository
    
    func execute(productIdx: UInt) {
        var cartToUpdate = cartRepository.load()
        guard productIdx < cartToUpdate.count else {
            return
        }
        cartToUpdate.remove(at: Int(productIdx))
        cartRepository.save(updatedCart: cartToUpdate)
    }
}
