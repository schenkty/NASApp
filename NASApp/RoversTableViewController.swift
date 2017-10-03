//
//  RoversTableViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class RoversTableViewController: UITableViewController {
    
    var roverItemsCollection: ([RoverItem], [RoverItem], [RoverItem]) = ([],[],[])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        pullingForAllRovers()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if let nextVC = segue.destination as? MarsPhotoCollectionViewController {
                switch indexPath.row {
                case 0:
                    nextVC.selectedRover = Rover.opportunity
                    nextVC.roverItems = self.roverItemsCollection.0
                case 1:
                    nextVC.selectedRover = Rover.curiosity
                    nextVC.roverItems = self.roverItemsCollection.1
                case 2:
                    nextVC.selectedRover = Rover.spirit
                    nextVC.roverItems = roverItemsCollection.2
                default: break
                }
            }
        }
    }
    
    // func that pull items for all the rovers
    func pullingForAllRovers() {
        self.pullingRoverItems(rover: Rover.curiosity)
        self.pullingRoverItems(rover: Rover.opportunity)
        self.pullingRoverItems(rover: Rover.spirit)
    }
    
    // function tht pulls the items for the selected rover
    func pullingRoverItems(rover: Rover) {
        
        var sol = 0
        switch rover {
        case .opportunity: sol = 4650
        case .curiosity: sol = 1634
        case .spirit: sol = 500
        }
        
        NetworkManager.pullRoversPhotos(rover: rover, sol: sol) {rover, json in
            for roverItem in json["photos"] {
                do {
                    switch rover {
                    case .opportunity: try self.roverItemsCollection.0.append(RoverItem(json: roverItem.1))
                    case .curiosity: try self.roverItemsCollection.1.append(RoverItem(json: roverItem.1))
                    case .spirit: try self.roverItemsCollection.2.append(RoverItem(json: roverItem.1))
                    }
                } catch  let error {
                    self.showAlert(title: "Error", message: "\(error)")
                }
            }
        }
    }
    
    func dataUnavailable() {
        showAlert(title: "Pulling Data", message: "Satellites Unavailable, retry in a moment!")
    }
}
