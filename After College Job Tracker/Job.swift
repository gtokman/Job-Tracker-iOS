//
//  Job.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Job: Equatable {
    let id: String
    var company: String
    var status: String
    var notification: Bool
}

extension Job {
    init?(snapshot: FIRDataSnapshot) {
        
        let data = snapshot.value as? [String: Any]
        
        guard let id = data?["id"] as? String,
            let company = data?["name"] as? String,
            let status = data?["status"] as? String,
            let notification = data?["notification"] as? Bool else {
                
                return nil
        }
        
        print("job is \(id) \(company) \(status) \(notification)")
        
        self.id = id
        self.company = company
        self.status = status
        self.notification = notification
    }
    
    func toJson() -> [String: Any] {
        let dict = [
            "id": id,
            "name": company,
            "status": status,
            "notification": notification
        ] as [String : Any]
        
        return dict
    }
}

func ==(rhs: Job, lhs: Job) -> Bool {
    return rhs.id == lhs.id
}
