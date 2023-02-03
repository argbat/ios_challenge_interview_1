//
//  ProductsRepositoryMocks.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import Combine
import Foundation

@testable import CabifyShop

//MARK: - Domain global instances
let product1Code = ProductCode("Code1")
let product2Code = ProductCode("Code2")

let product1 = Product(
    code: product1Code,
    name: "Name1",
    price: Decimal(1)
)

let product2 = Product(
    code: product2Code,
    name: "Name2",
    price: Decimal(2)
)

//MARK: - Products Repository Mocks

struct ErrorLoadProductsRepositoryMock: ProductsRepository {
    let error: RepositoryErrors
    let publisher = CurrentValueSubject<[Product], RepositoryErrors>([])

    func load() -> AnyPublisher<[Product], RepositoryErrors> {
        publisher.send(completion: .failure(error))
        return publisher.eraseToAnyPublisher()
    }
}

struct EmptyLoadProductsRepositoryMock: ProductsRepository {
    let publisher = CurrentValueSubject<[Product], RepositoryErrors>([])

    func load() -> AnyPublisher<[Product], RepositoryErrors> {
        return publisher.eraseToAnyPublisher()
    }
}

struct NotEmptyLoadProductsRepositoryMock: ProductsRepository {
    let publisher = CurrentValueSubject<[Product], RepositoryErrors>([
        product1
    ])
    
    func load() -> AnyPublisher<[Product], RepositoryErrors> {
        return publisher.eraseToAnyPublisher()
    }
}

//MARK: - Products Api Mocks

class ProductsApiMock: ProductsApi {
    let data: Data?
    let error: Error?
    let subject: CurrentValueSubject<Data, Error>
    
    init(data: Data?, error: Error?) {
        subject = CurrentValueSubject(Data())
        self.data = data
        self.error = error
    }
    
    func loadProducts() -> AnyPublisher<Data, Error> {
        if let data = data {
            subject.send(data)
        } else if let error = error {
            subject.send(completion: .failure(error))
        }
        return subject.eraseToAnyPublisher()
    }
}
