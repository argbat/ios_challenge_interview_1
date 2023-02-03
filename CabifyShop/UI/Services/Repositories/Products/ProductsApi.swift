//
//  Api.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine
import Foundation

/// Generic Api methods that we support from a products backend.
protocol ProductsApi {
    func loadProducts() -> AnyPublisher<Data, Error>
}
