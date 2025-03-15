//
//  StartViewModel.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import Foundation
import ShoppeStore

final class LoginViewModel: ObservableObject {
    @Published var shouldNavigateToHome: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAllertPresented: Bool = false
    @Published var alertMessage: String = ""
    
    let model = LoginModel()
    
    private func validateUser() -> Bool {
        alertMessage = "Incorrect email or password"
        
        if let users = try? ShoppeStore.shared.persistence.loadUsers().get() {
            for user in users {
                if user.email == email {
                    if user.password == password {
                        ShoppeStore.shared.persistence.currentUser = user
                        return true
                    } else {
                        return false
                    }
                }
            }
        }
        
        return false
    }
    
    func login() {
        if !validateUser(){
            isAllertPresented = true
            return
        }
        
        shouldNavigateToHome = true
    }
    
    func onAppear() {
        email = ""
        password = ""
    }
}
