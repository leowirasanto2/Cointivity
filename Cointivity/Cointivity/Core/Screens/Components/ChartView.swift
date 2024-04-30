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
    @Binding var selectedTimeFrame: ChartTimeframe
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ForEach(ChartTimeframe.allCases, id: \.rawValue) { tFrame in
                    Button {
                        selectedTimeFrame = tFrame
                    } label: {
                        Text(tFrame.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedTimeFrame.rawValue == tFrame.rawValue ? .orange : .blue)
                    }
                }
            }
            
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
//            .chartXAxis {
//                AxisMarks(position: .bottom, values: dates()) { value in
//                    AxisGridLine()
//                    AxisValueLabel() {
//                        if let dateValue = value.as(Date.self) {
//                            Text(formattedDate(dateValue))
//                        }
//                    }
//                }
//            }
            .chartYScale(domain: ClosedRange(uncheckedBounds: (lower: prices().min().orZero, upper: prices().max().orZero)))
            .chartScrollableAxes(.horizontal)
            .frame(maxHeight: 300)
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
    ChartView(selectedTimeFrame: .constant(.month))
}
