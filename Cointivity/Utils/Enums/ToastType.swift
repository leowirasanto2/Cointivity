//
//  ToastType.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import Foundation
import SwiftUI

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
