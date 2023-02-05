//
//  RemoveProductFromCartUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

class RemoveProductFromCartUseCase {
    private let cartRepository: CartRepository
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute(productIdx: UInt) {
        var cartToUpdate = cartRepository.load()
        guard productIdx < cartToUpdate.count else {
            return
        }
        cartToUpdate.remove(at: Int(productIdx))
        cartRepository.save(updatedCart: cartToUpdate)
    }
}
