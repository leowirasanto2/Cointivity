//
//  ChartModel.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import Dependencies
import Foundation
import SwiftUI

@MainActor
class ChartModel: ObservableObject {
    @Published var priceDataPoint: [PriceDataPoint] = []
    @Published var chartData: ChartData?
    @Published var timeFrame: ChartTimeframe = .day {
        didSet {
            guard let data = chartData?.getPriceDataPoint() else { return }
            priceDataPoint = data
        }
    }
    
    @Dependency(\.dummyJsonService) var dumJsonService
    
    func fetchChart() async {
        do {
            chartData = try await dumJsonService.get(timeFrame.response) as ChartData
        } catch {
            print(error)
        }
    }
    
    func setTimeFrame(_ tf: ChartTimeframe) {
        self.timeFrame = tf
    }
}
