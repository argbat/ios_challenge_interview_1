//
//  CartPageView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import SwiftUI

/// Use this view to display a cart page.
struct CartPageView: View {
    @ObservedObject var cartPresenter: CartPagePresenter
    
    var body: some View {
        CartView(
            cart: cartPresenter.cart,
            checkout: CheckoutPresentable(
                subtotal: "$30.00",
                showDiscounts: true,
                discounts: "$5.00",
                youWillPay: "$25.00"
            ),
            onRemove: { product in cartPresenter.removeProduct(product: product) }
        )
    }
}

/// Use this view to display a cart view.
struct CartView: View {
    let cart: CartPresentable
    let checkout: CheckoutPresentable
    let onRemove: (ProductItemPresentable) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Cart")
                    .font(.system(size: 26))
                Spacer()
            }.padding()
            Divider()
            List(cart.products, id: \.id) { product in
                ProductInCartItemView(
                    product: product,
                    onRemove: onRemove
                )
                .padding()
                .listRowSeparator(.hidden)
                .modifier(AsCard(backgroundColor: Color.white))
                .modifier(AsNotHlighlightedCell())
            }
            .listStyle(.plain)
            .modifier(
                AsEmpty(isEmpty: cart.showIsEmpty) {
                    VStack {
                        Spacer()
                        Text("Add items to cart and enjoy our great ")
                        Text("discounts.")
                            .foregroundColor(.indigo)
                            .italic()
                        Spacer()
                    }
                }
            )
            VStack {
                CartCheckoutView(checkout: checkout)
                    .padding()
                    .modifier(AsCard(backgroundColor: .white))
            }
            .padding()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(
            cart: CartPresentable(
                products: [
                    ProductItemPresentable(
                        code: "MUG",
                        name: "Cabify Coffee Mug",
                        promotion: "2For1 on this item",
                        showPromotion: true,
                        price: "$5.00"),
                    ProductItemPresentable(
                        code: "MUG",
                        name: "Cabify Coffee Mug",
                        promotion: "2For1 on this item",
                        showPromotion: true,
                        price: "$5.00"),
                    ProductItemPresentable(
                        code: "T-SHIRT",
                        name: "Cabify T-Shirt",
                        promotion: "",
                        showPromotion: false,
                        price: "$20.00")
                ],
                showIsEmpty: false),
            checkout: CheckoutPresentable(
                subtotal: "$30.00",
                showDiscounts: true,
                discounts: "$5.00",
                youWillPay: "$25.00"
            ),
            onRemove: {_ in}
        )
        
        CartView(
            cart: CartPresentable(
                products: [],
                showIsEmpty: true),
            checkout: CheckoutPresentable(
                subtotal: "$0.00",
                showDiscounts: true,
                discounts: "$0.00",
                youWillPay: "$0.00"
            ),
            onRemove: {_ in}
        )
    }
}
