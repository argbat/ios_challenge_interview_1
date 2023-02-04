//
//  CartCheckoutView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import SwiftUI

struct CartCheckoutView: View {
    let checkout: CheckoutPresentable
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Checkout")
                    .font(.system(size: 22))
                Divider()
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("SubTotal: \(checkout.subtotal)")
                        Text("Discounts: \(checkout.discounts)")
                            .foregroundColor(.indigo)
                            .italic()
                        Spacer().frame(maxHeight: 6)
                        Text("You Will Pay: \(checkout.youWillPay)")
                            .font(.system(size: 22))
                    }
                }
            }
        }
    }
}

struct CartCheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CartCheckoutView(
            checkout: CheckoutPresentable(
                subtotal: "$1000.00",
                showDiscounts: true,
                discounts: "$200.00",
                youWillPay: "$700.00"
            )
        )
        .previewLayout(.fixed(width: 320, height: 120))
    }
}
