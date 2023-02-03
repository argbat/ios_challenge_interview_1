//
//  ProductPromotionHint.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

struct ProductPromotionHint: View {
    let hint: String
    
    var body: some View {
        Text(hint)
            .foregroundColor(.indigo)
            .font(.system(size: 10))
            .italic()
            .lineLimit(2)
            .multilineTextAlignment(.leading)
    }
}

struct ProductPromotionHint_Previews: PreviewProvider {
    static var previews: some View {
        ProductPromotionHint(hint: "Hint")
    }
}
