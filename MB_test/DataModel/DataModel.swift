//
//  DataModel.swift
//  MB_test
//
//  Created by Zayd on 22.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class DataModel {
    
    var persons = [Person]()
    var json:JSON!
    init(){
        loadPersons()
        //loading persons from storage
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
    
    // Получение данных с сайта в формате JSON
    func getDataJSON(for pageIndex:Int) {
        let baseURL = "https://rickandmortyapi.com/api/character/"
        let Url = URL(string: baseURL + "?page=\(pageIndex)")!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: Url) {(data, response, error) in
            guard let data = data else { return }

            if let datajson = try? JSON(data: data){
                print("JSON page = \(pageIndex) did downloaded")
                self.json = datajson
                semaphore.signal()
            }
        }
        
        task.resume()
        semaphore.wait()
    }
    
    func getPersonsFrom(json:JSON){
        var downloadedPersons = [Person]()
        if let personsJSON = json["results"].array {
            for element in personsJSON{
                if let person = try? Person(json: element){
                    downloadedPersons.append(person)
                }else{
                    print("Init for \(element["name"]) failed")
                    return
                }
            }
            persons = downloadedPersons
        }
        else{
            print("Error with 'result' from JSON")
        }
        
    }
    
    func loadPersons(){
        let utilityQueue = DispatchQueue.global(qos: .utility)
        utilityQueue.sync {
            getDataJSON(for: 1)
            getPersonsFrom(json: self.json)
        }
        // Loads persons from file
    }
    
    func savePersons(){
        //Saves persons to file
    }
    
}
