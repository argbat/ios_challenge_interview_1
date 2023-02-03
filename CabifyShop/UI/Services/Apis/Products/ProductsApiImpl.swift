//
//  ProductsApi.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine
import Foundation

enum ApiErrors: Error, Equatable {
    case ResponseNotSupported
}

struct ProductsApiImpl: ProductsApi {
    let baseUrl: String
    let session: URLSession
    
    func loadProducts() -> AnyPublisher<Data, Error> {
        let url = URL(string: baseUrl.appending("palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json"))!
        return session.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw ApiErrors.ResponseNotSupported
                }
                return data
            })
            .eraseToAnyPublisher()
    }
}
