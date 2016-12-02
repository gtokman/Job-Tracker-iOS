//
//  JobsTableViewController.swift
//  After College Job Tracker
//
//  Created by g tokman on 11/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import FirebaseAuth

class JobsTableViewController: UITableViewController {
    
    fileprivate var jobs = [Job]()
    fileprivate var presenter: NewJobsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewJobsPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onStart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.onStop()
    }
    
    // MARK: - Actions
    
    @IBAction func onClickLogout(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func onClickAddJob(_ sender: UIBarButtonItem) {
    }
}

// MARK: - Table view data source

extension JobsTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let job = jobs[indexPath.row]
        presenter?.removeJob(job: job)
        
        jobs.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        
        let job = jobs[indexPath.row]
        cell.job = job
        
        return cell
    }
}

extension JobsTableViewController: JobsView {
    
    func showJob(job: Job) {
        if !jobs.contains(job) {
            jobs.append(job)
            let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
            tableView.insertRows(at: [indexPath], with: .top)
        }
    }
    
    func showProgressIndicator() {
        
    }
    
    func hideProgressIndicator() {
        
    }
    
    func showError(message: String) {
        print(message)
    }
}
