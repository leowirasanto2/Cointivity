//
//  TrendCoinScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import SwiftUI

struct TrendCoinScreen: View {
    @Binding var path: [PathRoute]
    @Binding var selected: Coin?
    var coins: [Coin] = []
    
    var body: some View {
        List {
            ForEach(coins, id: \.id) { result in
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
                    selected = result
                    path.append(.detailScreen)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    TrendCoinScreen(path: .constant([]), selected: .constant(Coin()), coins: [])
}
