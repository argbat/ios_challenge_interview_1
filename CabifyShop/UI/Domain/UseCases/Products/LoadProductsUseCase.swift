//
//  CabifyLoadProductsUseCase.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine

/// Use case that will load a llist of items.
struct LoadProductsUseCase {
    let productsRepository: ProductsRepository

    /// Execute this use case.
    ///
    /// - Returns A list of products or an empty list.
    func execute() -> AnyPublisher<[Product], RepositoryErrors> {
        return productsRepository.load().eraseToAnyPublisher()
    }
}
