//
//  MarketModel.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation
import Dependencies
import SwiftUI

@MainActor
class MarketModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var errorMessage: String?
    @Published var activeFilter: MarketFilterItem = .none
    
    @Dependency(\.dummyJsonService) var dumJsonService
    
    func fetchCoins() async {
        do {
            let response = try await dumJsonService.get("dummy-response") as [Coin]
            coins = response
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
    
    func displayingCoins() -> [Coin] {
        switch activeFilter {
        case .rank:
            return Array(coins.sorted {$0.marketCapRank.orZero > $1.marketCapRank.orZero })
        case .volume:
            return Array(coins.sorted {$0.totalVolume.orZero > $1.totalVolume.orZero })
        case .marketCap:
            return Array(coins.sorted {$0.marketCapChange24H.orZero > $1.marketCapChange24H.orZero })
        case .none:
            return coins
        }
    }
    
    func trendingCoins() -> [Coin] {
        return coins.count >= 6 ? Array(coins.prefix(6)) : coins
    }
    
    func trendingCoinIconPath() -> [String] {
        return trendingCoins().map(\.image.orEmpty)
    }
    
    func topGainers() -> [Coin] {
        return Array(coins.sorted { a, b in
            a.priceChange24H.orZero > b.priceChange24H.orZero
        }.prefix(6))
    }
    
    func topGainerIconPath() -> [String] {
        return topGainers().map(\.image.orEmpty)
    }
    
    func topLosers() -> [Coin] {
        return Array(coins.sorted { a, b in
            a.priceChange24H.orZero < b.priceChange24H.orZero
        }.prefix(6))
    }
    
    func topLoserIconPath() -> [String] {
        topLosers().map(\.image.orEmpty)
    }
}
