//
//  SignUpContract.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

protocol LoadingActions {
    func showProgressIndicator()
    func hideProgressIndicator()
    func showError(message: String)
}

protocol LoginActions: LoadingActions {
    func getEmailAddress() -> String?
    func getPassword() -> String?
    func segueAfterAuth()
}

protocol SignUpView: LoginActions {
    func getUserName() -> String?
}

protocol SignUpPresenter {
    func signInUser()
}

protocol LoginView: LoginActions {
    
}

protocol LoginPresenter {
    func loginUser()
    func userForgotPassword()
}


