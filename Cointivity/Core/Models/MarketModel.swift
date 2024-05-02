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
    @Published var chartDataPoint: ChartData?
    @Published var errorMessage: String?
    @Published var displayingCoins: [Coin] = []
    @Published var isEditingWatchList = false
    @Published var selectedCoinIds: [String] = []
    @Published var activeFilter: MarketFilterItem = .none {
        didSet {
            updateDisplayingCoins(oldValue, activeFilter)
        }
    }
    @Published var searchResult: [Coin] = []
    @Published var selectedCoin: Coin?
    @Published var selectedTrend: TrendSection = .trending
    @Environment(\.openURL) var openUrl
    
    @Dependency(\.dummyJsonService) var dumJsonService
    @Dependency(\.httpClientService) var httpClientService
    
    func fetchCoins() async {
        do {
            let resource = Resource(url: APIs.marketList.url, method: .get([URLQueryItem(name: "vs_currency", value: "usd")]), modelType: [Coin].self)
            let response = try await httpClientService.load(resource)
            coins = response
            displayingCoins = response
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func searchCoins(_ keyword: String) async {
        do {
            let response = try await dumJsonService.get("dummy-response") as [Coin]
            searchResult = response
        } catch {
            errorMessage = error.localizedDescription
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
    
    func isCoinSelected(_ coin: Coin) -> Bool {
        return selectedCoinIds.first(where: { $0 == coin.id.orEmpty }) != nil
    }
    
    func selectToEditAction(_ coin: Coin) {
        guard selectedCoinIds.first(where: { $0 == coin.id.orEmpty }) == nil else {
            selectedCoinIds.removeAll(where: { $0 == coin.id.orEmpty })
            return
        }
        selectedCoinIds.append(coin.id.orEmpty)
    }
    
    func trendingCoins(_ section: TrendSection) -> [Coin] {
        switch section {
        case .trending:
            return coins.count >= 6 ? Array(coins.prefix(6)) : coins
        case .topGainer:
            return Array(coins.sorted { a, b in
                a.priceChange24H.orZero > b.priceChange24H.orZero
            }.prefix(6))
        case .topLoser:
            return Array(coins.sorted { a, b in
                a.priceChange24H.orZero < b.priceChange24H.orZero
            }.prefix(6))
        }
    }
    
    func trendingCoinIconPath(_ section: TrendSection) -> [String] {
        return trendingCoins(section).map(\.image.orEmpty)
    }
}
