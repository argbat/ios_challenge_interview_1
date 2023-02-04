//
//  CabifyShopApp.swift
//  CabifyShop
//
//  Created by Demian Odasso on 03/02/2023.
//

import SwiftUI

@main
struct CabifyShopApp: App {
    let composer = Composer()
    
    var body: some Scene {
        WindowGroup {
            MainPageView(
                presenter: composer.makeMainPagePresenter(),
                productsPresenter: composer.makeProductsPagePresenter(),
                cartPresenter: composer.makeCartPagePresenter()
            )
        }
    }
}
