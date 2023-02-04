//
//  AsLoading.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

/// Replace a view's content with a loading indicator if losding is true.
struct AsLoading<OverContent: View>: View {
    let loading: Bool
    let overContent: OverContent

    var body: some View {
        if loading {
            overContent.overlay {
                ProgressView()
            }
            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
        } else {
            overContent
        }
    }
}
