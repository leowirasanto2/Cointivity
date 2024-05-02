//
//  TrendSection.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import Foundation

enum TrendSection: CaseIterable {
    case trending
    case topGainer
    case topLoser
    
    var title: String {
        switch self {
        case .trending:
            "🔥 Trending"
        case .topGainer:
            "📈 Top Gainers"
        case .topLoser:
            "📉 Top Losers"
        }
    }
}
