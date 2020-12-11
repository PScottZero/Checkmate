//
//  Colors.swift
//  Checkmate
//
//  Created by Paul Scott on 12/6/20.
//

import Foundation
import SwiftUI

struct Colors {
    static let imageBackground = Color(red: 0.2, green: 0.2, blue: 0.2)
    static let rankOneColor = Color(red: 237 / 255, green: 202 / 255, blue: 59 / 255)
    static let rankThreeColor = Color(red: 143 / 255, green: 105 / 255, blue: 80 / 255)
    static let greenGradient = LinearGradient(
        gradient: Gradient(colors: [
            .green,
            Color(red: 0, green: 255 / 255, blue: 200 / 255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let redGradient = LinearGradient(
        gradient: Gradient(colors: [
            .red,
            Color(red: 1, green: 0.5, blue: 0)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let blueGradient = LinearGradient(
        gradient: Gradient(colors: [
            .blue,
            Color(red: 0.5, green: 0.5, blue: 1)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let disabledGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.9, green: 0.9, blue: 0.9),
            Color(red: 0.8, green: 0.8, blue: 0.8)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let transparent = LinearGradient(
        gradient: Gradient(colors: [
            Color.white,
            Color(red: 0.9, green: 0.9, blue: 0.9)
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
