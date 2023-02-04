//
//  AsCard.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

/// Style a view as a card with rounded corners and a elevation using a shadow.
struct AsCard: ViewModifier {
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .background { backgroundColor }
            .cornerRadius(14)
            .shadow(radius: 4)
    }
}
