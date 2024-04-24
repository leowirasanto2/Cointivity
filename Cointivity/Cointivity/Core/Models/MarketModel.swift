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
    
    func priceDisplay(coin: Coin) -> String {
        return "$\(coin.currentPrice.orZero)"
    }
    
    func priceUpdateDisplay(coin: Coin) -> (value: String, color: Color) {
        let toPercent = coin.priceChangePercentage24H.orZero * 100
        let textDisplay = "\(coin.priceChange24H.orZero)" + "(\(toPercent)%)"
        return (value: textDisplay, color: toPercent >= 0 ? .green : .red)
    }
}
