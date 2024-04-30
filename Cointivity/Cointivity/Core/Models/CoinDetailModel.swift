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
    
    var currentPriceDisplay: String? {
        if let price = coinDetails?.marketData?.currentPrice?["usd"] {
            return price.formatted(.currency(code: "USD")).replacingOccurrences(of: "US", with: "")
        }
        return nil
    }
    
    var latestPriceChangeDisplay: String? {
        if let priceChange = coinDetails?.marketData?.priceChangePercentage24H {
            return "\(priceChange.minimalistStringDecimal)%"
        }
        return nil
    }
    
    var isPriceUp: Bool {
        (coinDetails?.marketData?.priceChangePercentage24H).orZero > 0
    }
    
    // MARK: - Statistic Section
    
    var fullyDilutedValuationInfo: [InfoRowItemValue]? {
        if let fullyDilutedValuation = coinDetails?.marketData?.fullyDilutedValuation?["fully_diluted_valuation"] {
            return [InfoRowItemValue(text: fullyDilutedValuation.formatted(.currency(code: "USD")).replacingOccurrences(of: "US", with: ""))]
        }
        return nil
    }
    
    var volume: [InfoRowItemValue]? {
        if let vol = coinDetails?.marketData?.totalVolume?["usd"] {
            return [InfoRowItemValue(text: vol.formatted(.currency(code: "USD")).replacingOccurrences(of: "US", with: ""))]
        }
        return nil
    }
    
    var marketCapInfo: [InfoRowItemValue]? {
        if let tradingVol24h = coinDetails?.marketData?.marketCap?["usd"] {
            return [InfoRowItemValue(text: tradingVol24h.formatted(.currency(code: "USD")).replacingOccurrences(of: "US", with: ""))]
        }
        return nil
    }
    
    var circulatingSupplyInfo: [InfoRowItemValue]? {
        if let circulatingSupply = coinDetails?.marketData?.circulatingSupply {
            return [InfoRowItemValue(text: circulatingSupply.minimalistStringDecimal)]
        }
        return nil
    }
    
    var totalSupplyInfo: [InfoRowItemValue]? {
        if let totalSupply = coinDetails?.marketData?.totalSupply {
            return [InfoRowItemValue(text: totalSupply.minimalistStringDecimal)]
        }
        return nil
    }
    
    var maxSupplyInfo: [InfoRowItemValue]? {
        if let maxSupply = coinDetails?.marketData?.maxSupply {
            return [InfoRowItemValue(text: "\(maxSupply)")]
        }
        return nil
    }
    
    // MARK: - Info Section
    func getRepoInfo() -> [InfoRowItemValue]? {
        var result: [InfoRowItemValue] = []
        
        if let github = coinDetails?.links?.reposURL?.github?.first {
            result.append(InfoRowItemValue(text: github.urlComp?.host, url: github))
        }
        
        if let bitbucket = coinDetails?.links?.reposURL?.bitbucket?.first {
            result.append(InfoRowItemValue(text: bitbucket.urlComp?.host, url: bitbucket))
        }
        
        return result.orNil
    }
    
    func getWhitepaperInfo() -> [InfoRowItemValue]? {
        guard let whitepaper = coinDetails?.links?.whitepaper, !whitepaper.isEmpty else { return nil }
        return [InfoRowItemValue(text: whitepaper.urlComp?.host, url: whitepaper)].orNil
    }
    
    func getWebsiteInfo() -> [InfoRowItemValue]? {
        return coinDetails?.links?.homepage?.compactMap { link -> InfoRowItemValue? in
            guard let urlComp = link.urlComp?.host else { return nil }
            return InfoRowItemValue(text: urlComp, url: link)
        }.orNil
    }
    
    func getExplorersInfo() -> [InfoRowItemValue]? {
        return coinDetails?.links?.blockchainSite?.compactMap { link -> InfoRowItemValue? in
            guard let urlComp = link.urlComp?.host else { return nil }
            return InfoRowItemValue(text: urlComp, url: link)
        }.orNil
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
