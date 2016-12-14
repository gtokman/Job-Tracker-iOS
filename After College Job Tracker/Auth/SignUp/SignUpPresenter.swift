//
//  SignUpPresenter.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import FirebaseAuth

class NewSignUpPresenter: SignUpPresenter {
    
    private let view: SignUpView
    
    init(view: SignUpView) {
        self.view = view
    }
    
    func signInUser() {
        if CheckNetwork.hasNetworkConnection() {
            view.showProgressIndicator()
            
            guard let email = view.getEmailAddress() , !email.isEmpty,
                let username = view.getUserName(), !username.isEmpty,
                let password = view.getPassword(), !password.isEmpty else {
                    view.showError(message: "No empty fields! 🙄")
                    view.hideProgressIndicator()
                    return
            }
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password) {
                (user, error) in
                
                self.view.hideProgressIndicator()
                
                guard error == nil else {
                    self.view.showError(message: error!.localizedDescription)
                    return
                }
                
                if let newUser = user {
                    print("We have a user \(newUser.email)")
                    self.view.segueAfterAuth()
                }
            }
        } else {
            view.showError(message: "No network connection 🙄")
        }
    }
}
