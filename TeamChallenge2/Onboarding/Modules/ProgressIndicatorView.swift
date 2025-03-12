//
//  ProgressIndicator.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct ProgressIndicatorView: View {
    @State var pages: [UUID]
    @Binding var selected: UUID?
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(pages, id: \.self) { page in
                Circle()
                    .fill(
                        page == selected
                        ? Color.accentColor
                        : Color.accentColor.opacity(0.2))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        selected = page
                    }
            }
        }
        .padding(20)
    }
}
