//
//  Chart.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

struct ChartData: Codable {
    let prices: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
    
    func getPriceDataPoint() -> [PriceDataPoint] {
        let result = prices.compactMap { data -> PriceDataPoint? in
            guard
                let date = data.first,
                let price = data.last else { return nil }
            let toDate = Date(timeIntervalSince1970: date)
            return PriceDataPoint(price: price, date: toDate)
        }
        return result
    }
}

struct PriceDataPoint {
    var price: Double
    var date: Date
}

extension ChartData {
    static let day = "chart-res-one-day"
    static let month = "chart-res-one-month"
    static let week = "chart-res-one-week"
    static let year = "chart-res-one-year"
}
