//
//  ToastView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import SwiftUI

struct Toast: Equatable {
    var message: String
    var type: ToastType
    var duration: ToastDuration
    
    enum ToastType {
        case info
        case error
        case success
        case warning
        
        var color: Color {
            switch self {
            case .info:
                return .gray
            case .error:
                return .red
            case .success:
                return .green
            case .warning:
                return .orange
            }
        }
    }

    enum ToastDuration {
        case long
        case medium
        case short
        
        var interval: Double {
            switch self {
            case .long:
                return 2
            case .medium:
                return 1.5
            case .short:
                return 0.5
            }
        }
    }
}

struct ToastView: View {
    var info: Toast
    
    var body: some View {
        VStack {
            Text(info.message)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(10)
        }
        .background(info.type.color.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: .infinity))
    }
}

#Preview {
    ToastView(info: Toast(message: "toast message", type: .warning, duration: .medium))
}
