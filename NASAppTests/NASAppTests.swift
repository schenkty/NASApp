//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import NASApp

class NASAppTests: XCTestCase {
    
    var daily: Daily?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
                    case .opportunity: print(try RoverItem(json: roverItem.1))
                    case .curiosity: print(try RoverItem(json: roverItem.1))
                    case .spirit: print(try RoverItem(json: roverItem.1))
                    }
                } catch let error {
                    print("error: \(error)")
                }
            }
        }
    }
    
    func pullingDaily() {
        NetworkManager.pullDaily {json in
            do {
                try self.daily = Daily(json: json)
            } catch  let error {
                print("error: \(error)")
            }
        }
    }
    
    // MARK: Build more testing to cover the rest of the features
    
    // Test Function to pull rover items
    func testPullAllRoverItems() {
        self.pullingRoverItems(rover: Rover.curiosity)
        self.pullingRoverItems(rover: Rover.opportunity)
        self.pullingRoverItems(rover: Rover.spirit)
    }
    
    func testPullDailyInfo() {
        self.pullingDaily()
        print(daily?.explanation)
    }
}
