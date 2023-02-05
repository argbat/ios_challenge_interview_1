//
//  ProductsRepositoryImpl.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine
import Foundation

/// A products repository implementation that only manage data from a backend.
class ProductsRepositoryImpl: ProductsRepository {
    private let api: ProductsApi

    init(api: ProductsApi) {
        self.api = api
    }
    
    func load() -> AnyPublisher<[Product], RepositoryErrors> {
        api.loadProducts()
            .decode(type: LoadProductsResponse.self, decoder: JSONDecoder())
            .compactMap { $0.map() }
            .mapError { _ in RepositoryErrors.UnableToLoad }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
