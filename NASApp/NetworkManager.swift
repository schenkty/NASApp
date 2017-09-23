//
//  NetworkManager.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import AlamofireImage
import CoreLocation

class NetworkManager {

    // Store API url and API Key
    private static let base_url = "https://api.nasa.gov/"
    private static let api_key = "7vJEGuOyEOmK8n0Vfmd8l4KTeTYZoW5gtQTydQPl"
    static let shared = NetworkManager()

    class func pullDaily(completion: @escaping (JSON) -> ()) {
        
        // Setting the url for the request
        let url = "\(base_url)planetary/apod?api_key=\(api_key)"
        
        // Making the request
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func pullImage(url: String, withIdentifier: String, completion: @escaping (UIImage) -> ()) {
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    class func pullRoversPhotos(rover: Rover, sol: Int, completion: @escaping (Rover, JSON) -> ()) {
        
        // Setting the url for the request
        let url = "\(base_url)mars-photos/api/v1/rovers/\(rover.rawValue)/photos?sol=\(sol)&api_key=\(api_key)"
        
        // Making the request
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(rover, json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
