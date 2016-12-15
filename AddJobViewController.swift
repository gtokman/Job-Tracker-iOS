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
    
    @IBOutlet weak var jobTextField: UITextField? {
        didSet{
            if let job = job {
                jobTextField?.text = job.company
            }
        }
    }
    @IBOutlet weak var statusSegControl: UISegmentedControl? {
        didSet {
            if let job = job {
                if job.status == "Sent Resume" {
                    statusSegControl?.selectedSegmentIndex = 0
                } else {
                    statusSegControl?.selectedSegmentIndex = 1
                }
            }
        }
    }
    @IBOutlet weak var notificationSwitch: UISwitch? {
        didSet {
            if let job = job {
                notificationSwitch?.isOn = job.notification
            }
        }
    }
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    public var job: Job?
    fileprivate var presenter: NewAddJobsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewAddJobsPresenter(view: self)
    }
    
    // MARK: - Actions
    
    @IBAction func onClickSave(_ sender: UIBarButtonItem) {
        if let job = job {
            presenter?.updateJobPost(job: job)
        } else {
            presenter?.saveJobPost()
        }
    }
}

// MARK: - Jobs View

extension AddJobViewController: AddJobsView {
    
    func getCompanyName() -> String? {
        return jobTextField?.text
    }
    
    func getStatusValue() -> String? {
        return statusSegControl!.titleForSegment(at: statusSegControl!.selectedSegmentIndex)
    }
    
    func getNotificationValue() -> Bool {
        return notificationSwitch!.isOn
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
