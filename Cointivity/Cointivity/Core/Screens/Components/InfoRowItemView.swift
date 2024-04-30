//
//  InfoRowItemView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import SwiftUI

struct InfoRowItemValue {
    var id = UUID().uuidString
    var text: String?
    var url: String?
    var iconurl: String?
}

struct InfoRowItemView: View {
    var title: String
    var values: [InfoRowItemValue]
    @State var showPicker: Bool = false
    
    var onUrlSelected: (String) -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            if !values.isEmpty {
                Button {
                    if values.count > 1 {
                        showPicker = true
                    } else {
                        onUrlSelected((values.first?.url).orEmpty)
                    }
                } label: {
                    HStack {
                        if let url = URL(string: (values.first?.iconurl).orEmpty) {
                            AsyncImage(url: url) { result in
                                result.image?.resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 25)
                            }
                        }
                        Text((values.first?.text).orEmpty)
                            .foregroundStyle(.black)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .padding(8)
                    .background(.gray.opacity(0.2))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .sheet(isPresented: $showPicker, content: {
            VStack {
                ForEach(values, id: \.id) { value in
                    Button {
                        showPicker = false
                    } label: {
                        HStack {
                            if let url = URL(string: value.iconurl.orEmpty) {
                                AsyncImage(url: url) { result in
                                    result.image?.resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 25)
                                }
                            }
                            Text(value.text.orEmpty)
                                .foregroundStyle(.black)
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .padding(8)
                        .background(.gray.opacity(0.2))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .presentationDetents([.medium])
        })
    }
}

#Preview {
    InfoRowItemView(title: "Title", values: [
        InfoRowItemValue(text: "Text", url: "https://assets.coingecko.com/coins/images/4128/thumb/solana.png?1696504756", iconurl: "https://assets.coingecko.com/coins/images/4128/thumb/solana.png?1696504756"),
        InfoRowItemValue(text: "Text", url: "https://assets.coingecko.com/coins/images/4128/thumb/solana.png?1696504756", iconurl: "https://assets.coingecko.com/coins/images/4128/thumb/solana.png?1696504756")
    ]) { _ in }
}
