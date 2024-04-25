//
//  FilterButton.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct FilterButtonView: View {
    var isActive: Bool = false
    var text: String
    var leftIcon: Image? = nil
    var rightIcon: Image? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                if let leftIcon = leftIcon {
                    leftIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 8)
                }
                
                Text(text)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                if let rightIcon = rightIcon {
                    rightIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 8)
                }
            }
            .foregroundStyle(isActive ? .white : .black)
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(isActive ? .green : .white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

#Preview {
    FilterButtonView(isActive: false, text: "Action", rightIcon: Image(systemName: "chevron.down")) {}
}
