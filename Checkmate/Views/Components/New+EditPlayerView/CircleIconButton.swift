//
//  CircleButton.swift
//  Checkmate
//
//  Created by Paul Scott on 11/6/20.
//

import SwiftUI

struct CircleIconButton: View {
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: ViewConstants.circleIconSize, height: ViewConstants.circleIconSize)
                .padding(ViewConstants.smallPadding)
                .background(Circle().foregroundColor(.white))
                .shadow(radius: ViewConstants.smallShadow)
        }
    }
}
