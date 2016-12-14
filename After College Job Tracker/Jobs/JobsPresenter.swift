//
//  JobsPresenter.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class NewJobsPresenter: JobsPresenter {
    
    private var view: JobsView
    
    init(view: JobsView) {
        self.view = view
    }
    
    func onStart() {
        
        FIRAuth.auth()?.addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.view.showLoginView()
            }
        }
        
        view.showProgressIndicator()
        
        let jobsRef = FIRDatabase.database().reference().child("users")
            .child(FIRAuth.auth()!.currentUser!.uid).child("jobs")
        
        jobsRef.observe(.childAdded, with: { (snapshot) in
            self.view.hideProgressIndicator()
            let job = Job(snapshot: snapshot)
            if let job = job {
                self.view.showJob(job: job)
            }
        }) { (error) in
            self.view.hideProgressIndicator()
            self.view.showError(message: error.localizedDescription)
        }
        
        jobsRef.observe(.childChanged, with: { (snapshot) in
            self.view.hideProgressIndicator()
            
            let job = Job(snapshot: snapshot)
            if let job = job {
                self.view.updateJob(job: job)
            }
            
        }) { (error) in
            self.view.hideProgressIndicator()
            self.view.showError(message: error.localizedDescription)
        }
    }
    
    func removeJob(job: Job) {
        view.showProgressIndicator()
        
        let jobsRef = FIRDatabase.database().reference().child("users")
            .child(FIRAuth.auth()!.currentUser!.uid).child("jobs").child(job.id)
        
        jobsRef.removeValue { (error, ref) in
            self.view.hideProgressIndicator()
            
            guard error == nil else {
                self.view.showError(message: error!.localizedDescription)
                return
            }
        }
    }
    
    func onStop() {
        
    }
    
    func logoutUser() {
        view.showProgressIndicator()
        do {
            view.hideProgressIndicator()
            try FIRAuth.auth()?.signOut()
        } catch let error {
            view.hideProgressIndicator()
            view.showError(message: error.localizedDescription)
        }
    }
}
