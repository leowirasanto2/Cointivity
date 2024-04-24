//
//  TrendingMarketItem.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct StackCoinItemView: View {
    let imageUrl: URL?
    var iconSize: CGFloat = 25
    
    var body: some View {
        VStack {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: iconSize)
            } placeholder: {
                ProgressView()
            }
        }
        .clipShape(Circle())
    }
}

#Preview {
    StackCoinItemView(imageUrl: URL(string: "https://assets.coingecko.com/coins/images/4128/large/solana.png?1696504756"))
}
