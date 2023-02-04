//
//  AsNotHighlightedCell.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import SwiftUI

/// If a cell contains a button and you do not want to
/// have a cell back highlight by defualt then use this modifier.
struct AsNotHlighlightedCell: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
    }
}
