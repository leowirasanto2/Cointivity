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
class ChartModel: ObservableObject {
    @Published var priceDataPoint: [PriceDataPoint] = []
    @Published var chartData: ChartData?
    @Published var timeFrame: ChartTimeframe = .day
    @Published var selectedCoin: Coin?
    @Dependency(\.dummyJsonService) var dumJsonService
    private var anyCancellables: Set<AnyCancellable> = []
    var path: Binding<[PathRoute]>
    
    init(coin: Coin?, path: Binding<[PathRoute]>) {
        self.path = path
        self.selectedCoin = coin
        listenTimeframe()
        listenChartData()
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
