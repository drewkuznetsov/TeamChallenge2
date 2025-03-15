//
//  StartViewModel.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import Foundation
import ShoppeStore

final class CreateAccountViewModel: ObservableObject {
    @Published var shouldNavigateToHome: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAllertPresented: Bool = false
    @Published var alertMessage: String = ""
    
    let model = CreateAccountModel()
    
    private func valideteTextFields() -> Bool {
        let emailPattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let passwordPattern = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailPattern)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        
        if !emailPredicate.evaluate(with: email) {
            alertMessage = "Enter a valid email"
            return false
        }
        
        if !passwordPredicate.evaluate(with: password) {
            alertMessage = "The password must be at least 8 characters long and contain at least one letter and one number"
            return false
        }
        
        return true
    }
    
    private func validateNewUser() -> Bool {
        let users = (try? ShoppeStore.shared.persistence.loadUsers().get()) ?? []
        
        if users.contains(where: { $0.email == email }) {
            alertMessage = "User with this email already exists"
            return false
        }
        
        let user = ShoppeUser(
            id: 0,
            username: "Enter your name",
            email: email,
            password: password
        )
        
        ShoppeStore.shared.persistence.saveUsers(users + [user])
        ShoppeStore.shared.persistence.currentUser = user
        
        return true
    }
    
    func createAccount() {
        if !valideteTextFields() || !validateNewUser() {
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
