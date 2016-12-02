//
//  LoginPresenter.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import FirebaseAuth

class NewLoginPresenter: LoginPresenter {
    
    private var view: LoginView
    
    init(view: LoginView) {
        self.view = view
    }
    
    func loginUser() {
        
        view.showProgressIndicator()
        
        guard let email = view.getEmailAddress(), !email.isEmpty,
        let password = view.getPassword(), !password.isEmpty else {
            view.hideProgressIndicator()
            view.showError(message: "No empty fields! 🙄")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) {
            (user, error) in
            
            guard error == nil else {
                self.view.hideProgressIndicator()
                self.view.showError(message: error!.localizedDescription)
                return
            }
            
            if let user = user {
                print("Signing in user \(user.email)")
                self.view.hideProgressIndicator()
                self.view.segueAfterAuth()
            }
        }
    }
    
    func userForgotPassword() {
        print("Forgot password")
    }
}
