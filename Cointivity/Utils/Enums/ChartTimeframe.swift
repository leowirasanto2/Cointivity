//
//  ChartTimeframe.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import Foundation

enum ChartTimeframe: String, CaseIterable {
    case day = "1D"
    case week = "1W"
    case month = "1M"
    case year = "1Y"
}

extension ChartTimeframe {
    var value: Int {
        switch self {
        case .day:
            return 1
        case .week:
            return 7
        case .month:
            return 30
        case .year:
            return 365
        }
    }
    var response: String {
        switch self {
        case .day:
            ChartData.day
        case .week:
            ChartData.week
        case .month:
            ChartData.month
        case .year:
            ChartData.year
        }
    }
}
