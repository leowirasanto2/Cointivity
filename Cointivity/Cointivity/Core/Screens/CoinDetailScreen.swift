//
//  CoinDetailScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import SwiftUI

struct CoinDetailScreen: View {
    @EnvironmentObject var model: ChartModel
    
    var body: some View {
        VStack {
            ChartView(dataPoints: model.priceDataPoint, selectedTimeFrame: $model.timeFrame)
            Text("points available -> \(model.priceDataPoint.count)")
        }
    }
}

#Preview {
    CoinDetailScreen()
        .environmentObject(ChartModel())
}
