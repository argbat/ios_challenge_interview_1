//
//  AsCard.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

/// Style a view as a card with rounded corners and a elevation using a shadow.
struct AsCard: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .background { colorScheme == .light ? Color.white : Color.black }
            .cornerRadius(14)
            .shadow(radius: 4)
    }
}
