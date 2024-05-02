//
//  ToastModifier.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 02/05/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var info: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    toastView()
                        .offset(y: 32)
                }
                    .animation(.spring(), value: info)
            )
            .onChange(of: info, { _, _ in
                show()
            })
    }
    
    @ViewBuilder func toastView() -> some View {
        if let info = info {
            VStack {
                ToastView(info: info)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }
        }
    }
    
    private func show() {
        guard let info = info else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if info.duration.interval > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismiss()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + info.duration.interval, execute: task)
        }
    }
    
    private func dismiss() {
        withAnimation {
            info = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
