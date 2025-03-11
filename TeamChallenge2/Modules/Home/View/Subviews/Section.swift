//
//  SectionHeader.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 11.03.2025.
//

import SwiftUI

struct Section<Content> : View where Content: View {
    let title: String
    let content: Content
    let onTapSeeAll: () -> Void
    
    init(title: String, content: @escaping () -> Content, onTapSeeAll: @escaping () -> Void) {
        self.title = title
        self.content = content()
        self.onTapSeeAll = onTapSeeAll
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text(title)
                    .font(.system(size: 21, weight: .black))
                Spacer()
                
                Button(action: {
                    onTapSeeAll()
                }) {
                    Text("See All")
                        .font(.system(size: 15, weight: .black))
                    Image(.seeAll)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .foregroundStyle(.black)
                
            }
            
            content
        }
    }
}

#Preview {
    Section(title: "Categories") {
        Text("Something")
    } onTapSeeAll: { print("See all") }
}
