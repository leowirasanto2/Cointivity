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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.currentPrice = try container.decodeIfPresent(Double.self, forKey: .currentPrice)
        self.marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
        self.marketCapRank = try container.decodeIfPresent(Int.self, forKey: .marketCapRank)
        self.fullyDilutedValuation = try container.decodeIfPresent(Double.self, forKey: .fullyDilutedValuation)
        self.totalVolume = try container.decodeIfPresent(Int.self, forKey: .totalVolume)
        self.high24H = try container.decodeIfPresent(Double.self, forKey: .high24H)
        self.low24H = try container.decodeIfPresent(Double.self, forKey: .low24H)
        self.priceChange24H = try container.decodeIfPresent(Double.self, forKey: .priceChange24H)
        self.priceChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .priceChangePercentage24H)
        self.marketCapChange24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChange24H)
        self.marketCapChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChangePercentage24H)
        self.circulatingSupply = try container.decodeIfPresent(Double.self, forKey: .circulatingSupply)
        self.totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupply)
        self.maxSupply = try container.decodeIfPresent(Double.self, forKey: .maxSupply)
        self.ath = try container.decodeIfPresent(Double.self, forKey: .ath)
        self.athChangePercentage = try container.decodeIfPresent(Double.self, forKey: .athChangePercentage)
        self.athDate = try container.decodeIfPresent(String.self, forKey: .athDate)
        self.atl = try container.decodeIfPresent(Double.self, forKey: .atl)
        self.atlChangePercentage = try container.decodeIfPresent(Double.self, forKey: .atlChangePercentage)
        self.atlDate = try container.decodeIfPresent(String.self, forKey: .atlDate)
        self.roi = try container.decodeIfPresent(Roi.self, forKey: .roi)
        self.lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
    }
    
    init(id: String?, symbol: String?, name: String?, image: String?, currentPrice: Double?, marketCap: Double?, marketCapRank: Int?, fullyDilutedValuation: Double?, totalVolume: Int?, high24H: Double?, low24H: Double?, priceChange24H: Double?, priceChangePercentage24H: Double?, marketCapChange24H: Double?, marketCapChangePercentage24H: Double?, circulatingSupply: Double?, totalSupply: Double?, maxSupply: Double?, ath: Double?, athChangePercentage: Double?, athDate: String?, atl: Double?, atlChangePercentage: Double?, atlDate: String?, roi: Roi?, lastUpdated: String?) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.totalVolume = totalVolume
        self.high24H = high24H
        self.low24H = low24H
        self.priceChange24H = priceChange24H
        self.priceChangePercentage24H = priceChangePercentage24H
        self.marketCapChange24H = marketCapChange24H
        self.marketCapChangePercentage24H = marketCapChangePercentage24H
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.roi = roi
        self.lastUpdated = lastUpdated
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
