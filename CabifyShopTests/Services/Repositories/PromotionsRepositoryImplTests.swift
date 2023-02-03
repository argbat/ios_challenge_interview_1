//
//  PromotionsRepositoryImplTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class PrmotionsRepositoryImplTests: XCTestCase {
    func test_load_notEmptyPromotions() {
        let sut = PromotionsRepositoryImpl()
        
        XCTAssertFalse(sut.load().isEmpty)
    }
}
