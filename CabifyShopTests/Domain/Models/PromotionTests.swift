//
//  PromotionTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class PromotionUseCaseTests: XCTestCase {
    func test_isForProductCode_true() {
        let sut = Promotion(code: .discount,
                            productCodes: ["Code1"],
                            description: "Description")
        
        XCTAssertTrue(sut.isForProductCode(code: "Code1"))
    }
    
    func test_isForProductCode_false() {
        let sut = Promotion(code: .discount,
                            productCodes: ["Code1"],
                            description: "Description")
        
        XCTAssertFalse(sut.isForProductCode(code: "Code2"))
    }
    
    func test_isForProductCode_noCaseMatch_false() {
        let sut = Promotion(code: .discount,
                            productCodes: ["code1"],
                            description: "Description")
        
        XCTAssertFalse(sut.isForProductCode(code: "Code1"))
    }
}
