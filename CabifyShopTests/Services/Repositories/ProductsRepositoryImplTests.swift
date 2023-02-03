//
//  ProductsRepositoryImplTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class ProductsRepositoryImplTests: XCTestCase {
    func test_load_notEmptyProducts() {
        let api = ProductsApiMock(data: ProductsApiResponseStrings.GetNotEmpty.data,
                                  error: nil)
        let sut = ProductsRepositoryImpl(api: api)
        
        let exp = expectation(description: "wait for load")
        let cancelable = sut.load().sink { completion in
            switch completion {
            case .failure:
                XCTFail()
                exp.fulfill()
            case .finished:
                exp.fulfill()
            }
        } receiveValue: { products in
            XCTAssertEqual(products.isEmpty, false)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
    
    func test_load_emptyProducts() {
        let api = ProductsApiMock(data: ProductsApiResponseStrings.GetEmpty.data,
                                  error: nil)
        let sut = ProductsRepositoryImpl(api: api)
        
        let exp = expectation(description: "wait for load")
        let cancelable = sut.load().sink { completion in
            switch completion {
            case .failure:
                XCTFail()
                exp.fulfill()
            case .finished:
                exp.fulfill()
            }
        } receiveValue: { products in
            XCTAssertEqual(products.isEmpty, true)
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
    
    func test_load_unableToLoad_reasonNetworkError() {
        let api = ProductsApiMock(data: nil,
                                  error: ProductsApiResponseErrors.GetNetworkError.error)
        let sut = ProductsRepositoryImpl(api: api)
        
        let exp = expectation(description: "wait for load")
        let cancelable = sut.load().sink { completion in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .UnableToLoad)
                exp.fulfill()
            case .finished:
                exp.fulfill()
            }
        } receiveValue: { _ in
            XCTFail()
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
    
    func test_load_unableToLoad_reasonParseError() {
        let api = ProductsApiMock(data: ProductsApiResponseStrings.GetInvalidData.data,
                                  error: nil)
        let sut = ProductsRepositoryImpl(api: api)
        
        let exp = expectation(description: "wait for load")
        let cancelable = sut.load().sink { completion in
            switch completion {
            case .failure(let error):
                XCTAssertEqual(error, .UnableToLoad)
                exp.fulfill()
            case .finished:
                exp.fulfill()
            }
        } receiveValue: { _ in
            XCTFail()
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        cancelable.cancel()
    }
}

// MARK: - Helpers

fileprivate enum ProductsApiResponseStrings {
    case GetNotEmpty
    case GetEmpty
    case GetInvalidData
    
    var data: Data {
        var data: Data
        switch self {
        case .GetNotEmpty:
            data = """
            {
            "products": [
              {
                "code": "VOUCHER",
                "name": "Cabify Voucher",
                "price": 5
              }
            ]
            }
            """.data(using: .utf8) ?? Data("".utf8)
        case .GetEmpty:
            data = """
            {
            "products": []
            }
            """.data(using: .utf8) ?? Data("".utf8)
        case .GetInvalidData:
            // invalid data is the price property, should be a Number not a string.
            data = """
            {
            "products": [
              {
                "code": "VOUCHER",
                "name": "Cabify Voucher",
                "price": "5"
              }
            ]
            }
            """.data(using: .utf8) ?? Data("".utf8)
        }
        return data
    }
}

fileprivate enum ProductsApiResponseErrors {
    case GetNetworkError
    
    var error: Error {
        switch self {
        case .GetNetworkError:
            return URLError(.notConnectedToInternet)
        }
    }
}
