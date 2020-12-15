//
//  AIDifficultyPicker.swift
//  Checkmate
//
//  Created by Paul Scott on 12/1/20.
//

import SwiftUI

enum AIDifficulty: String, CaseIterable {
    case easy, normal, hard, impossible
}

struct AIDifficultyPicker: View {
    @Binding var aiDifficulty: AIDifficulty
    
    var body: some View {
        VStack {
            Text("AI Difficulty")
            Picker("", selection: $aiDifficulty) {
                ForEach(AIDifficulty.allCases, id: \.self) {
                    Text($0.rawValue.capitalized).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .environment(\.colorScheme, .dark)
        }
    }
}
