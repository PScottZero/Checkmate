//
//  ViewConstants.swift
//  Checkmate
//
//  Created by Paul Scott on 11/8/20.
//

import Foundation
import SwiftUI

struct ViewConstants {
    
    // sizing and spacing
    static let chessSceneSize = CGSize(width: 320, height: 320)
    static let chessFrameSize: CGFloat = 320
    static let largeSpacing: CGFloat = 20
    static let mediumSpacing: CGFloat = 15
    static let largeImageSize: CGFloat = 200
    static let smallImageSize: CGFloat = 60
    static let logoHeight: CGFloat = 80
    static let infoHeight: CGFloat = 30
    static let circleIconSize: CGFloat = 20
    static let gearIconSize: CGFloat = 25
    static let rankSize: CGFloat = 45
    static let savePreviewSize: CGFloat = 160
    static let chessViewImageSize: CGFloat = 40
    
    // padding
    static let largePadding: CGFloat = 40
    static let mediumPadding: CGFloat = 20
    static let smallPadding: CGFloat = 10
    
    // radii
    static let cornerRadius: CGFloat = 10
    static let largeShadow: CGFloat = 10
    static let smallShadow: CGFloat = 5
    
    // line widths
    static let largeLineWidth: CGFloat = 10
    static let mediumLineWidth: CGFloat = 6
    static let smallLineWidth: CGFloat = 3
    
    // font sizing
    static let largeFont: CGFloat = 32
    static let mediumFont: CGFloat = 24
    static let smallFont: CGFloat = 20
    static let smallestFont: CGFloat = 16
    
    // other
    static let opaque: Double = 1.0
    static let transparent: Double = 0.1
    static let imageCompression: CGFloat = 75
    static let defaultRating: Int32 = 1200
    static let timerMultiplier = 1800
    static let timerTagMultiplier = 30
    static let player1 = 1
    static let player2 = 2
    static let timeRange = 1...5
}
