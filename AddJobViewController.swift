//
//  AddJobViewController.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class AddJobViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var statusSegControl: UISegmentedControl!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    fileprivate var presenter: NewAddJobsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewAddJobsPresenter(view: self)
    }
    
    @IBAction func onClickSave(_ sender: UIBarButtonItem) {
        presenter?.saveJobPost()
    }
}

extension AddJobViewController: AddJobsView {
    
    func getCompanyName() -> String? {
        return jobTextField.text
    }
    
    func getStatusValue() -> String? {
        return statusSegControl.titleForSegment(at: statusSegControl.selectedSegmentIndex)
    }
    
    func getNotificationValue() -> Bool {
        return notificationSwitch.isOn
    }
    
    func showProgressIndicator() {
        progressIndicator.startAnimating()
    }
    
    func hideProgressIndicator() {
        progressIndicator.stopAnimating()
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
