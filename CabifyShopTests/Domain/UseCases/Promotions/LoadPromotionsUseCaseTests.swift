//
//  LoadPromotionsUseCaseTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class LoadPromotionsUseCaseTests: XCTestCase {
    func test_execute_emptyResult() {
        let promoRepo = EmptyPromotionsRepositoryMock()
        let sut = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        
        XCTAssertTrue(sut.execute().isEmpty)
    }
    
    func test_execute_notEmptyResult() {
        let promoRepo = PromotionsRepositoryMock()
        let sut = LoadPromotionsUseCase(promotionsRepository: promoRepo)
        
        XCTAssertFalse(sut.execute().isEmpty)
    }
}
