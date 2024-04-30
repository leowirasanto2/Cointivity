//
//  ChartView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    var dataPoints: [PriceDataPoint] = []
    var coin: Coin
    @Binding var selectedTimeFrame: ChartTimeframe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(coin.name.orEmpty) Price Chart (\(coin.symbol.orEmpty.uppercased()))")
            HStack {
                ForEach(ChartTimeframe.allCases, id: \.rawValue) { tFrame in
                    Button {
                        selectedTimeFrame = tFrame
                    } label: {
                        Text(tFrame.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedTimeFrame.rawValue == tFrame.rawValue ? .black : .black.opacity(0.5))
                            .padding(8)
                            .background(selectedTimeFrame.rawValue == tFrame.rawValue ? .white : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(4)
            }
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Chart {
                ForEach(dataPoints, id: \.id) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("Price", point.price)
                    )
                    .interpolationMethod(.cardinal)
                }
            }
            .chartXScale(domain: .automatic(dataType: Date.self) { _ in })
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: prices().min().orZero, upper: prices().max().orZero)))
            .frame(height: 300)
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func dates() -> [Date] {
        return dataPoints.map(\.date)
    }
    
    func prices() -> [Double] {
        return dataPoints.map(\.price)
    }
}

#Preview {
    ChartView(dataPoints: PriceDataPoint.getDummyPriceData(), coin: Coin(), selectedTimeFrame: .constant(.day))
}
