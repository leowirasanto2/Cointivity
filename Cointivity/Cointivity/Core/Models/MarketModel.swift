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
    @Published var displayingCoins: [Coin] = []
    @Published var activeFilter: MarketFilterItem = .none {
        didSet {
            updateDisplayingCoins(oldValue, activeFilter)
        }
    }
    
    @Dependency(\.dummyJsonService) var dumJsonService
    
    func fetchCoins() async {
        do {
            let response = try await dumJsonService.get("dummy-response") as [Coin]
            coins = response
            displayingCoins = response
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
    
    func updateDisplayingCoins(_ oldFilter: MarketFilterItem, _ newFilter: MarketFilterItem) {
        switch newFilter {
        case .rank:
            displayingCoins = Array(coins.sorted {$0.marketCapRank.orZero > $1.marketCapRank.orZero })
        case .volume:
            displayingCoins = Array(coins.sorted {$0.totalVolume.orZero > $1.totalVolume.orZero })
        case .marketCap:
            displayingCoins = Array(coins.sorted {$0.marketCapChange24H.orZero > $1.marketCapChange24H.orZero })
        case .sortBy:
            break
        case .none:
            displayingCoins = coins
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
