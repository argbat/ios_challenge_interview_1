//
//  CabifyButton.swift
//  CabifyShop
//
//  Created by Demian Odasso on 31/01/2023.
//

import SwiftUI

struct CabifyButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .bold()
        }
        .tint(.indigo)
        .buttonStyle(.borderedProminent)
        .controlSize(.regular)
    }
}

struct CabifyButton_Previews: PreviewProvider {
    static var previews: some View {
        CabifyButton(text: "Text", action: {})
    }
}
