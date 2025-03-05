//
//  TeamChallenge2App.swift
//  TeamChallenge2
//
//  Created by Андрей Кузнецов on 03.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("text")
            switch vm.state {
            case .loading:
                ProgressView()
                
            case .loaded(let array):
                if let first = array.first {
                    ForEach(first.products, id: \.title) { element in
                        AsyncImage(url: element.image) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }

                    }
                }
                
            case .error(let error):
                EmptyView()
            }
        }
        .task(vm.onAppear)
    }
}

@main
struct TeamChallenge2App: App {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
