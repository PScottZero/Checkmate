//
//  RoundedButton.swift
//  Checkmate
//
//  Created by Paul Scott on 11/8/20.
//

import SwiftUI

struct RoundedButton: View {
    let label: String
    let gradient: LinearGradient
    let disabled: Bool
    let action: () -> Void
    var opacity: Double
    
    init(_ label: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label;
        gradient = Colors.transparent;
        self.disabled = disabled
        self.action = action
        opacity = ViewConstants.transparent
    }
    
    init(_ label: String, gradient: LinearGradient, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.gradient = gradient
        self.disabled = disabled
        self.action = action
        opacity = ViewConstants.opaque
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: ViewConstants.smallFont))
                .foregroundColor(disabled ? .red : .white)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                        .fill(disabled ? Colors.disabledGradient : gradient)
                        .opacity(opacity)
                )
        }
        .shadow(radius: ViewConstants.smallShadow)
        .buttonStyle(BorderlessButtonStyle())
        .disabled(disabled)
    }
}
