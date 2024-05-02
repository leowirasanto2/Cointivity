//
//  ViewExt.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import Foundation
import SwiftUI

extension View {
    func toastView(_ info: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(info: info))
    }
}
