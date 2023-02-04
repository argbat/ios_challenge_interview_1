//
//  CartRepository.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine

/// Defines the behavior that a Cart Repository should have.
protocol CartRepository {
    /// Use this publisher to be notified of updates on the cart repository.
    var didSave: AnyPublisher<[Product], Never> { get }
    
    /// Load a cart from the repository.
    func load() -> [Product]
    
    /// Save a cart to the repository.
    ///
    /// Notifies changes by `didUpdate` publisher.
    func save(updatedCart: [Product])
}
