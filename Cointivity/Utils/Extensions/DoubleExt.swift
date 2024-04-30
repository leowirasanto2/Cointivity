//
//  DoubleExt.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Decimal {
    var orZero: Decimal {
        return self ?? 0.0
    }
}

extension Double {
    var minimalistStringDecimal: String {
        return String(format: "%.2f", self)
    }
}
