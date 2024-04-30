//
//  ChartModel.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import Combine
import Dependencies
import Foundation
import SwiftUI

@MainActor
class CoinDetailModel: ObservableObject {
    @Published var priceDataPoint: [PriceDataPoint] = []
    @Published var chartData: ChartData?
    @Published var timeFrame: ChartTimeframe = .day
    @Published var selectedCoin: Coin?
    @Published var coinDetails: CoinDetail?
    @Dependency(\.dummyJsonService) var dumJsonService
    @Environment(\.openURL) var openUrl
    private var anyCancellables: Set<AnyCancellable> = []
    var path: Binding<[PathRoute]>
    
    init(coin: Coin?, path: Binding<[PathRoute]>) {
        self.path = path
        self.selectedCoin = coin
        listenTimeframe()
        listenChartData()
    }
    
    func fetchCoinDetail() async {
        do {
            coinDetails = try await dumJsonService.get("coin-detail-res")
        } catch {
            print(error)
        }
    }
    
    func getWebsiteInfo() -> [InfoRowItemValue] {
        return coinDetails?.links?.homepage?.compactMap { link -> InfoRowItemValue? in
            guard let urlComp = link.urlComp?.host else { return nil }
            return InfoRowItemValue(text: urlComp, url: link)
        } ?? []
    }
    
    func getExplorersInfo() -> [InfoRowItemValue] {
        return coinDetails?.links?.blockchainSite?.compactMap { link -> InfoRowItemValue? in
            guard let urlComp = link.urlComp?.host else { return nil }
            return InfoRowItemValue(text: urlComp, url: link)
        } ?? []
    }
    
    func openUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        openUrl(url)
    }
    
    private func listenTimeframe() {
        $timeFrame.sink { value in
            Task {
                await self.fetchChart()
            }
        }.store(in: &anyCancellables)
    }
    
    private func listenChartData() {
        $chartData.sink { data in
            guard let priceData = data?.getPriceDataPoint() else { return }
            self.priceDataPoint = priceData
        }.store(in: &anyCancellables)
    }
    
    private func fetchChart() async {
        do {
            chartData = try await dumJsonService.get(timeFrame.response) as ChartData
        } catch {
            print(error)
        }
    }
}
