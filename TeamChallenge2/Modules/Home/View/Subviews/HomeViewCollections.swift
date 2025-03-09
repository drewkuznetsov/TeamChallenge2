//
//  HomeViewContent.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import SwiftUI

struct HomeViewCollections: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                Text("Some content")
                Text("Some content")
                Text("Some content")
            }
        }
    }
}

#Preview {
    HomeViewCollections()
}
