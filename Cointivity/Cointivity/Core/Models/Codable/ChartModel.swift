//
//  Chart.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

struct ChartModel: Codable {
    let prices: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
