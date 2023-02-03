//
//  Loading.swift
//  CabifyShop
//
//  Created by Demian Odasso on 03/02/2023.
//

import SwiftUI

struct LoadingView: View {
    let show: Bool
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
            .opacity(show ? 1.0 : 0.0)
    }
}
