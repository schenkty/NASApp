//
//  Models.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol JSONDecodable {
    init(json: JSON) throws
}

enum NasaError: Error {
    case NoDecodable(String)
    case CantLoadData(String)
}

class Daily: JSONDecodable {
    var imageURL: String
    var title: String
    var explanation: String
    var image: UIImage?
    
    init(withTitle title: String, imageURL: String, explanation: String) {
        self.title = title
        self.explanation = explanation
        self.imageURL = imageURL
        
        getImage(withURL: self.imageURL, withID: self.title)
    }
    
    required convenience init(json: JSON) throws {
        guard let title = json["title"].string,
            let imageURL = json["url"].string,
            let explanation = json["explanation"].string else {
                
            throw NasaError.NoDecodable("data not decodable")
        }
        
        self.init(withTitle: title, imageURL: imageURL, explanation: explanation)
    }
    
    func getImage(withURL url: String, withID id:String) {
        if let cachedImage = imageCache.image(for: URLRequest(url: URL(string: url)!), withIdentifier: id) {
            self.image =  cachedImage
        } else {
            NetworkManager.pullImage(url: url, withIdentifier: id, completion: { image in
                imageCache.add(image, for: URLRequest(url: URL(string: url)!), withIdentifier: id)
                self.image = image
            })
        }
    }
    
}

struct Location {
    var latitude: Double
    var longitude: Double
}

class EarthLocationData: JSONDecodable {
    var imageURL: String
    var id: String
    var image: UIImage?
    
    init(withId id: String, imageURL: String) {
        self.id = id
        self.imageURL = imageURL
    }
    
    required convenience init(json: JSON) throws {
        guard let id = json["id"].string,
            let imageURL = json["url"].string else {
                throw NasaError.NoDecodable("data not decodable")
        }
        self.init(withId: id, imageURL: imageURL)
    }
}

enum Rover: String {
    case curiosity = "curiosity"
    case opportunity = "opportunity"
    case spirit = "spirit"
}

class RoverItem {
    var id: String
    var imageURL: String
    
    init(withId id: String, imageURL url: String) {
        self.id = id
        self.imageURL = url
    }
    
    required convenience init(json: JSON) throws {
        guard let id = json["id"].int,
            let imageURL = json["img_src"].string else {
                throw NasaError.NoDecodable("data not decodable")
        }
        self.init(withId: "\(id)", imageURL: imageURL)
    }
}
