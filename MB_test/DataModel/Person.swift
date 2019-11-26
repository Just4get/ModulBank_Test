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
    let location: String
    let image:UIImage?
    let episode:Int
    let url:String
    let created:String

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
            let image = Person.downloadImage(from: imageURL) else{
                print("Have not 'image'")
                return nil
        }
        
        guard let locationJSON = json["location"].dictionary,
            let locationName = locationJSON["name"]?.stringValue
            else{
                print("Have not 'location'")
                return nil
        }
        let location = locationName
        
        
        guard let episodesCount = json["episode"].arrayObject?.count else{
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
        
        self.id = id
        self.name = name != "" ? name : "unknown"
        self.status = status == "" ? "unkown": status
        self.species = species
        self.type = type == "" ? "unkown": type
        self.gender = gender
        self.location = location
        self.image = image
        self.episode = episodesCount
        self.url = url
        self.created = dateString
    }
    
    init(personFromDB:PersonCD){
        self.id = Int(personFromDB.id)
        self.name = personFromDB.name!
        self.species = personFromDB.species!
        self.status = personFromDB.status!
        self.type = personFromDB.type!
        self.gender = personFromDB.gender!
        self.location = personFromDB.location!
        self.image = UIImage(data: personFromDB.image!)
        self.episode = Int(personFromDB.episode)
        self.url = personFromDB.url!
        self.created = personFromDB.created!
    }
    
    static func downloadImage(from url:URL) -> UIImage?{
        var image:UIImage?
        if let data = try? Data(contentsOf: url){
            image = UIImage(data: data)
        }
        else{
            print("Can not download image from \(url.absoluteString)")
        }
        return image
    }
    
}


