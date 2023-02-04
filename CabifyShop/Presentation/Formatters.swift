//
//  Formatters.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import Foundation

extension NumberFormatter {
    /// Formats a decimal to a representable price.
    ///
    /// We assume that the current currency is $.
    func priceFormatter(price: Decimal) -> String? {
        let priceFormatter = NumberFormatter()
        priceFormatter.maximumFractionDigits = 2
        priceFormatter.minimumFractionDigits = 2
        priceFormatter.currencyCode = "$"
        priceFormatter.numberStyle = .currency
        return priceFormatter.string(for: price) // TODO look into Decimal.formatted
    }
}
