//
//  RoundedAlertButton.swift
//  Checkmate
//
//  Created by Paul Scott on 12/7/20.
//

import SwiftUI

struct RoundedAlertButton: View {
    let label: String
    let message: String
    let actionText: String
    let disabled: Bool
    let dangerous: Bool
    let action: () -> Void
    @State var shouldShowAlert: Bool = false
    
    init(_ label: String, message: String, actionText: String, dangerous: Bool = false, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.message = message
        self.actionText = actionText
        self.dangerous = dangerous
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        Group {
            if dangerous {
                RoundedButton(label, gradient: Colors.redGradient, disabled: disabled) {
                    shouldShowAlert = true
                }
            } else {
                RoundedButton(label, disabled: disabled) {
                    shouldShowAlert = true
                }
            }
        }.alert(isPresented: $shouldShowAlert) {
            Alert(
                title: Text(label),
                message: Text(message),
                primaryButton: .destructive(Text(actionText)) { action() },
                secondaryButton: .cancel()
            )
        }
    }
}
