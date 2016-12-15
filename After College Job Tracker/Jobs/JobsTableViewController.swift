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
    fileprivate var progressIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProgressIndicator()
        
        if FIRAuth.auth()?.currentUser == nil {
            let authStoryBoard: UIStoryboard? = UIStoryboard(name: "Auth", bundle: Bundle.main)
            if let authView = authStoryBoard?.instantiateViewController(withIdentifier: "AuthStoryBoard") {
                present(authView, animated: true, completion: nil)
                return
            }
        }
        
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
    
    func initProgressIndicator() {
        progressIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        progressIndicator?.activityIndicatorViewStyle = .gray
        progressIndicator?.center = view.center
        progressIndicator?.hidesWhenStopped = true
        view.addSubview(progressIndicator!)
    }
    
    // MARK: - Actions
    
    @IBAction func onClickLogout(_ sender: UIBarButtonItem) {
        presenter?.logoutUser()
    }
    
    @IBAction func onClickAddJob(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddJob", sender: nil)
    }
}

// MARK: - Update the table view from custom cell

extension JobsTableViewController: UpdateTableView {
    func updateTable() {
        
//        tableView.reloadData()
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
        cell.delegate = self
        
        return cell
    }
}

// MARK: - Table view delegate

extension JobsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddJobViewController
        if segue.identifier == "AddJob" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let job = jobs[indexPath.row]
                destinationVC.job = job
            }
        }
    }
}

// MARK: - JobsView

extension JobsTableViewController: JobsView {
    
    func showJob(job: Job) {
        if !jobs.contains(job) {
            jobs.append(job)
            let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
            tableView.insertRows(at: [indexPath], with: .top)
        }
    }
    
    func updateJob(job: Job) {
        let index = jobs.index(of: job)
        jobs.remove(at: index!)
        jobs.insert(job, at: index!)
        tableView.reloadData()
    }
    
    func showLoginView() {
        
        let authStoryBoard: UIStoryboard? = UIStoryboard(name: "Auth", bundle: Bundle.main)
        if let authView = authStoryBoard?.instantiateViewController(withIdentifier: "AuthStoryBoard") {
            self.present(authView, animated: true, completion: nil)
        }
    }
    
    func showProgressIndicator() {
        progressIndicator?.startAnimating()
    }
    
    func hideProgressIndicator() {
        progressIndicator?.stopAnimating()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
