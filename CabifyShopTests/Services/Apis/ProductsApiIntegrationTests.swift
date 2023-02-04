//
//  ProductsApiIntegrationTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class ProductsApiIntegrationTests: XCTestCase {
    let timeout = TimeInterval(30)

    func test_lodProducts_notEmpty() {
        let sut = ProductsApiImpl(
            baseUrl: "https://gist.githubusercontent.com/",
            session: URLSession.shared
        )
        
        let exp = expectation(description: "wait for load")
        let cancelable = sut.loadProducts().sink { completion in
            switch completion {
            case .failure:
                XCTFail()
            case .finished:
                exp.fulfill()
            }
        } receiveValue: { products in
            XCTAssertEqual(products.isEmpty, false)
        }
        waitForExpectations(timeout: timeout)
        cancelable.cancel()
    }
}
