//
//  AddJobViewController.swift
//  After College Job Tracker
//
//  Created by g tokman on 11/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class AddJobViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickSave(_ sender: UIBarButtonItem) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
