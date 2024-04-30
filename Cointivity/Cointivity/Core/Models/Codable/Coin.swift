//
//  Coin.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

struct Coin: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap: Double?
    let marketCapRank: Int?
    let fullyDilutedValuation: Double?
    let totalVolume: Int?
    let high24H: Double?
    let low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    var isSelected: Bool = false
    
    mutating func setSelected(_ value: Bool) {
        self.isSelected = value
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}

struct Roi: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

extension Coin {
    init() {
        self.init(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 64658,
            marketCap: 1273972802248,
            marketCapRank: 1,
            fullyDilutedValuation: 1358758352929,
            totalVolume: 24272511009,
            high24H: 67058,
            low24H: 64564,
            priceChange24H: -1761.5205474212562,
            priceChangePercentage24H: -2.65211,
            marketCapChange24H: -36014640427.28735,
            marketCapChangePercentage24H: -2.74924,
            circulatingSupply: 19689615,
            totalSupply: 21000000,
            maxSupply: 21000000,
            ath: 73738,
            athChangePercentage: -11.98632,
            athDate: "2024-03-14T07:10:36.635Z",
            atl: 67.81,
            atlChangePercentage: 95609.22418,
            atlDate: "2013-07-06T00:00:00.000Z",
            roi: .init(),
            lastUpdated: "2024-04-24T15:56:25.526Z"
        )
    }
}

extension Roi {
    init() {
        self.init(times: nil, currency: nil, percentage: nil)
    }
}
