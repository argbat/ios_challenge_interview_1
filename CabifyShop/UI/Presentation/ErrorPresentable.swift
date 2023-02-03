//
//  ErrorPresentable.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

/// Holds representable data for an error message.
struct ErrorPresentable {
    static let empty = ErrorPresentable(title: "", message: "")
    
    let title: String
    let message: String
}
