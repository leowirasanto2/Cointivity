//
//  MarketFilterItem.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

enum MarketFilterItem: String, CaseIterable {
    case rank = "Rank"
    case volume = "Volume"
    case marketCap = "Market Cap 24H"
    case sortBy = "Sort"
    case none = "Reset"
}
