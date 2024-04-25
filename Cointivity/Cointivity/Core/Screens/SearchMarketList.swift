//
//  SearchMarketList.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct SearchMarketList: View {
    @StateObject var model: MarketModel
    @State private var searchPrompt = ""
    @State private var searching = true
    @Binding var path: [PathRoute]
    
    var body: some View {
        List {
            ForEach(searchResultDisplay, id: \.id) { result in
                HStack(alignment: .center, spacing: 16) {
                    
                    Text("#\(result.marketCapRank.orZero)")
                        .font(.footnote)
                        .foregroundStyle(.gray.opacity(0.8))
                    
                    AsyncImage(url: URL(string: result.image.orEmpty)) { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                        
                    } placeholder: {
                        Circle()
                            .foregroundStyle(.gray.opacity(0.1))
                            .frame(height: 30)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(result.symbol.orEmpty)
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        Text(result.name.orEmpty)
                            .font(.footnote)
                            .foregroundStyle(.gray.opacity(0.8))
                    }
                }
                .onTapGesture {
                    searching = false
                    model.marketItemSelectedAction(result)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Search Coin")
        .searchable(text: $searchPrompt, isPresented: $searching)
        .onAppear {
            Task {
                await model.searchCoins("")
            }
        }
    }
    
    var searchResultDisplay: [Coin] {
        if searchPrompt.isEmpty {
            return model.searchResult
        }
        return model.searchResult.filter { $0.symbol.orEmpty.lowercased().contains(searchPrompt.lowercased()) || $0.name.orEmpty.lowercased().contains(searchPrompt.lowercased()) }
    }
}

#Preview {
    SearchMarketList(model: MarketModel(), path: .constant([]))
}

