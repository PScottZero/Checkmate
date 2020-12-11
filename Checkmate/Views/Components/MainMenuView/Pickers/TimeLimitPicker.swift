//
//  TimeLimitPicker.swift
//  Checkmate
//
//  Created by Paul Scott on 11/17/20.
//

import SwiftUI

struct TimeLimitPicker: View {
    @Binding var minutes: Int
    
    var body: some View {
        VStack {
            Text("Time Limit")
            Picker("", selection: $minutes) {
                Text("None").tag(0)
                ForEach(ViewConstants.timeRange, id: \.self) {
                    Text("\($0 * ViewConstants.timerTagMultiplier) m").tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .environment(\.colorScheme, .dark)
        }
    }
}
