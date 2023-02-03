//
//  ProductsRepository.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine

/// Enumerated products repository errors.
enum RepositoryErrors: Error, Equatable {
    /// The repository did not load any data because of a load error.
    case UnableToLoad
}

/// Defines the behavior that a Products Repository should have.
protocol ProductsRepository {
    /// Load a list of items.
    ///
    /// - Returns A list of `Products` or and empty list.
    func load() -> AnyPublisher<[Product], RepositoryErrors>
}
