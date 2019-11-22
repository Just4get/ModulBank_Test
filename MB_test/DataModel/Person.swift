//
//  Person.swift
//  MB_test
//
//  Created by Zayd on 21.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class Person{
    let id:Int
    let name:String
    let status:String
    let species:String
    let type:String
    let gender:String
    let location: (name:String, url:String)
    let image:UIImage?
    let episode:[String]
    let url:String
    let created:Date
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init?(json: JSON) throws {
        
        guard let id = json["id"].int else {
            print("Have not 'id'")
            return nil
        }
        guard let name = json["name"].string else {
            print("Have not 'name'")
            return nil
        }
        guard let status = json["status"].string else {
            print("Have not 'status'")
            return nil
        }
        guard let species = json["species"].string else {
            print("Have not 'species'")
            return nil
        }
        guard let type = json["type"].string else {
            print("Have not 'type'")
            return nil
        }
        guard let gender = json["gender"].string else {
            print("Have not 'gender'")
            return nil
        }
        
        guard let imageURLString = json["image"].string,
            let imageURL = URL(string:imageURLString),
            let image = downloadImage(from: imageURL) else{
                print("Have not 'image'")
                return nil
        }
        
        guard let locationJSON = json["location"].dictionary,
            let locationName = locationJSON["name"]?.stringValue,
            let locationUrl = locationJSON["url"]?.string
            else{
                print("Have not 'location'")
                return nil
        }
        let location = (locationName, locationUrl)
        
        
        guard let episode = json["episode"].arrayObject as? [String] else{
            print("Have not 'episode'")
            return nil
        }
        
        guard let url = json["url"].string else{
            print("Have not 'url'")
            return nil
        }
        
        guard let dateString = json["created"].string else {
            print("Have not 'created'")
            return nil
        }
        
        let date = Date(timeIntervalSince1970: 1212121)
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = date
    }
    
}

func downloadImage(from url:URL) -> UIImage?{
    var image:UIImage?
    if let data = try? Data(contentsOf: url){
        image = UIImage(data: data)
    }
    else{
        print("Can not download image from \(url.absoluteString)")
    }
    return image
}
