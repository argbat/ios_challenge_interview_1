//
//  AsEmpty.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import SwiftUI

/// Replace a content view with an empty view.
struct AsEmpty<EmptyView: View>: ViewModifier {
    let isEmpty: Bool
    let emptyView: () -> EmptyView

    func body(content: Content) -> some View {
        if isEmpty {
            emptyView()
        } else {
            content
        }
    }
}
