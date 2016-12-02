//
//  JobTableViewCell.swift
//  After College Job Tracker
//
//  Created by g tokman on 12/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var companName: UILabel!
    @IBOutlet weak var jobStatus: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    
    public var job: Job? {
        didSet {
            if let job = job {
                companName.text = job.company
                jobStatus.text = job.status
                notificationImage.isHidden = !job.notification
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
