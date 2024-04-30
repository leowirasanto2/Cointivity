//
//  FilterScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.dismiss) var dismiss
    @Binding var activeFilter: MarketFilterItem
    var filters: [MarketFilterItem] = MarketFilterItem.allCases
    
    var body: some View {
        VStack(spacing: 16) {
            let displayedFilters = filters.filter { $0 != .sortBy }
            ForEach(displayedFilters, id: \.rawValue) { item in
                FilterButtonView(isActive: isActive(item), text: item.rawValue) {
                    activeFilter = item
                    dismiss()
                }
            }
        }
    }
    
    private func isActive(_ selected: MarketFilterItem) -> Bool {
        if selected == .none {
            return false
        }
        return activeFilter == selected
    }
}

#Preview {
    FilterScreen(activeFilter: .constant(.none))
}
