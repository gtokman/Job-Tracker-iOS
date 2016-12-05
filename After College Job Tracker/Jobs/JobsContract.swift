//
//  JobsContract.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

protocol JobsView: LoadingActions {
    func showJob(job: Job)
    func showLoginView()
}

protocol JobsPresenter {
    func onStart()
    func onStop()
    func logoutUser()
    func removeJob(job: Job)
}
