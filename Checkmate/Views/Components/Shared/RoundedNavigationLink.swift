//
//  RoundedNavigationLink.swift
//  Checkmate
//
//  Created by Paul Scott on 11/17/20.
//

import SwiftUI

struct RoundedNavigationLink: View {
    let label: String
    let destination: AnyView
    @Binding var isActive: Bool
    let disabled: Bool
    let action: () -> Void
    
    init(label: String, destination: AnyView, isActive: Binding<Bool>, disabled: Bool, action: @escaping () -> Void = {}) {
        self.label = label
        self.destination = destination
        self._isActive = isActive
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        NavigationLink(
            destination: destination,
            isActive: $isActive
        ) {
            RoundedButton(label, disabled: disabled) {
                isActive = true
                action()
            }
        }
        .disabled(disabled)
    }
}
