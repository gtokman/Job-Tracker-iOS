//
//  SignUpViewController.swift
//  After College Job Tracker
//
//  Created by g tokman on 11/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    private var presenter: NewSignUpPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = NewSignUpPresenter(view: self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickSignUp(_ sender: UIButton) {
        presenter?.signInUser()
    }
}

extension SignUpViewController: SignUpView {
    
    func getEmailAddress() -> String? {
        return emailTextField.text
    }
    
    func getUserName() -> String? {
        return userNameTextField.text
    }
    
    func getPassword() -> String? {
        return passwordTextField.text
    }
    
    func showProgressIndicator() {
        progressIndicator.startAnimating()
    }
    
    func hideProgressIndicator() {
        progressIndicator.stopAnimating()
    }
    
    func segueAfterAuth() {
        performSegue(withIdentifier: "ShowJobs", sender: nil)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
