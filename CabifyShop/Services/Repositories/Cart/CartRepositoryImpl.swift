//
//  CartRepositoryImpl.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine
import Foundation

class CartRepositoryImpl: CartRepository {
    var didSave: AnyPublisher<[Product], Never> {
        subscriber.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }

    private var cart: [Product] = []
    private let subscriber = PassthroughSubject<[Product], Never>()
    
    func load() -> [Product] {
        cart
    }
    
    func save(updatedCart: [Product]) {
        cart.removeAll()
        cart.append(contentsOf: updatedCart)
        subscriber.send(cart)
    }
}
