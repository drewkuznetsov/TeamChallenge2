//
//  TeamChallenge2App.swift
//  TeamChallenge2
//
//  Created by Андрей Кузнецов on 03.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("text")
    }
}

@main
struct TeamChallenge2App: App {
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task(vm.onAppear)
        }
    }
}
