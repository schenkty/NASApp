//
//  LandingTableViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class LandingTableViewController: UITableViewController {

    // It stores the data of the daily image
    var daily: Daily?
    
    // Set number of tableview rows
    let numberOfTableViewRows = 3
    
    // Set number of tableview sections
    let numberOfTableViewSections = 1

    override func viewWillAppear(_ animated: Bool) {
        //Start to download the data even beofre the view appears
        pullingDaily()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pullingDaily() {
        NetworkManager.pullDaily {json in
            do {
                try self.daily = Daily(json: json)
            } catch  let error {
                self.showAlert(title: "error", message: "\(error)")
            }
        }
    }
    
    func dataUnavailable() {
        showAlert(title: "Pulling Data", message: "Satellites Unavailable, retry in a moment!")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfTableViewSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfTableViewRows
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDaily" {
            if let nextVC = segue.destination as? DailyTableViewController {
                nextVC.daily = self.daily
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showDaily" {
            // check if daily data is nil or not
            if (self.daily?.image == nil || self.daily?.title == nil || self.daily?.explanation == nil) {
                dataUnavailable()
                return false
            }
            return true
        }
        
        // by default, transition
        return true
    }

}
