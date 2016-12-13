//
//  AddJobPresenter.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class NewAddJobsPresenter: AddJobsPresenter {
    
    fileprivate var view: AddJobsView
    
    init(view: AddJobsView) {
        self.view = view
    }
    
    func saveJobPost() {
        view.showProgressIndicator()
        guard let company = view.getCompanyName(), !company.isEmpty,
            let status = view.getStatusValue(), !status.isEmpty else {
                view.hideProgressIndicator()
                view.showError(message: "No empty fields! 🙄")
                return
        }
        
        let jobRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("jobs").childByAutoId()
        
        let job = Job(id: jobRef.key, company: company, status: status, notification: view.getNotificationValue())
        
        jobRef.updateChildValues(job.toJson()) { (error, ref) in
            
            self.view.hideProgressIndicator()
            
            guard error == nil else {
                self.view.showError(message: error!.localizedDescription)
                return
            }
            
            self.view.popViewController()
        }
    }
    
    func updateJobPost(job: Job) {
        view.showProgressIndicator()
        var job = job
        guard let company = view.getCompanyName(), !company.isEmpty,
            let status = view.getStatusValue(), !status.isEmpty else {
                view.hideProgressIndicator()
                view.showError(message: "No empty fields! 🙄")
                return
        }
        
        let jobRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("jobs").child(job.id)
        
        job.company = view.getCompanyName()!
        job.status = view.getStatusValue()!
        job.notification = view.getNotificationValue()
        
        jobRef.updateChildValues(job.toJson()) { (error, ref) in
            guard error == nil else {
                self.view.hideProgressIndicator()
                self.view.showError(message: error!.localizedDescription)
                return
            }
            
            self.view.hideProgressIndicator()
            self.view.popViewController()
        }
    }
}
