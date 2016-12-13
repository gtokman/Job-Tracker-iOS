//
//  AddJobContract.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation


protocol AddJobsView: LoadingActions {
    func getCompanyName() -> String?
    func getStatusValue() -> String?
    func getNotificationValue() -> Bool
    func popViewController()
}

protocol AddJobsPresenter {
    func saveJobPost()
    func updateJobPost(job: Job)
}
