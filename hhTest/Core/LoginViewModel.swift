//
//  LoginViewModel.swift
//  hhTest
//
//  Created by Валентина Дорина on 14.03.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isUserLoggedIn = false
    

    func login() {
            // Предположим, что вход выполнен успешно
            DispatchQueue.main.async {
                self.isUserLoggedIn = true // Обновляем состояние на главной очереди
            }
        print(isUserLoggedIn)
        }
}

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
}
