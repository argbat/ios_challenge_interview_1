//
//  ProductNameView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 31/01/2023.
//

import SwiftUI

struct ProductNameView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 18))
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
    }
}

struct ProductNameView_Previews: PreviewProvider {
    static var previews: some View {
        ProductNameView(name: "Name")
    }
}
