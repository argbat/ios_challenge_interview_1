//
//  ProductPriceView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 03/02/2023.
//

import SwiftUI

struct ProductPriceView: View {
    let price: String
    
    var body: some View {
        Text(price)
            .font(.system(size: 22))
            .bold()
    }
}

struct ProductPriceView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPriceView(price: "$20.00")
    }
}
