//
//  StartViewModel.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import Foundation

final class CreateAccountViewModel: ObservableObject {
    @Published var shouldNavigateToHome: Bool = false
    
    let model = CreateAccountModel()
    
    private func valideteNewAccount() -> Bool {
#warning("TO DO: Сделать валиадцию")
        return true
    }
    
    func createAccount() {
        guard valideteNewAccount() else { return }
        
        shouldNavigateToHome = true
    }
}
