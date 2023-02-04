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
let productWithOutPromotionCode = ProductCode("ProductWithOutPromotionCode")

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

let productWithOutPromotion = Product(
    code: productWithOutPromotionCode,
    name: "Name2",
    price: Decimal(20)
)

let promotionProduct1Code = Promotion(
    code: .discount,
    productCodes: [product1Code],
    description: "Discount"
)

let promotionProduct2Code = Promotion(
    code: .twoForOne,
    productCodes: [product2Code],
    description: "2For1"
)

let promotionEmpty = Promotion(
    code: .empty,
    productCodes: [],
    description: ""
)

//MARK: - Cart Repository Mocks
class CartRepositoryMock: CartRepository {
    var didSave: AnyPublisher<[Product], Never> {
        subject.eraseToAnyPublisher()
    }
    
    private(set) var cart: [Product] = []
    private let subject = CurrentValueSubject<[Product], Never>([])

    func load() -> [Product] {
        cart
    }
    
    func save(updatedCart: [CabifyShop.Product]) {
        cart.removeAll()
        cart.append(contentsOf: updatedCart)
        subject.send(cart)
    }
}

// MARK: - Promotions Repositiry Mocks
class EmptyPromotionsRepositoryMock: PromotionsRepository {
    func load() -> [Promotion] {
        []
    }
}

class PromotionsRepositoryMock: PromotionsRepository {
    private let repo: [Promotion] = [promotionProduct1Code, promotionProduct2Code]
    
    func load() -> [Promotion] {
        repo
    }
}

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
