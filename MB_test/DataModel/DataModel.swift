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
import CoreData

class DataModel {
    
    var persons = [Person]()
    var json:JSON!
    let pageIndex = 1
    
    var isDataLoaded:Bool{
        get {
            return UserDefaults.standard.bool(forKey: "isDataLoaded")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isDataLoaded")
        }
    }
    
    init(){
        loadPersons()
    }

    // Loading persons
    func loadPersons(){
        let utilityQueue = DispatchQueue.global(qos: .userInitiated)
        utilityQueue.sync {
            if !isDataLoaded {
                getDataJSON(for: pageIndex)
                getPersonsFrom(json: json)
                savePersons()
                isDataLoaded = true
            }
            else
            {
                loadPersonsFromDB()
            }
        }
    }
    
    // Fetching data from network in JSON format
    func getDataJSON(for pageIndex:Int) {
        let baseURL = "https://rickandmortyapi.com/api/character/"
        let Url = URL(string: baseURL + "?page=\(pageIndex)")!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: Url) {(data, response, error) in
            guard let data = data else { return }
            
            if let datajson = try? JSON(data: data){
                self.json = datajson
                semaphore.signal()
            }
        }
        
        task.resume()
        semaphore.wait()
    }
    // Creating persons
    func getPersonsFrom(json:JSON){
        var downloadedPersons = [Person]()
        if let personsJSON = json["results"].array {
            for element in personsJSON{
                if let person = try? Person(json: element){
                    downloadedPersons.append(person)
                }else{
                    return
                }
            }
            persons = downloadedPersons
        }
        else{
            print("Error with 'result' from JSON")
        }
    }
    

    
    //Saving persons to file
    func savePersons(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonCD", in: context)!
        
        for person in persons {
            let newPerson = NSManagedObject(entity: entity, insertInto: context)
            newPerson.setValue(person.id, forKey: "id")
            newPerson.setValue(person.created, forKey: "created")
            newPerson.setValue(person.episode, forKey: "episode")
            newPerson.setValue(person.gender, forKey: "gender")
            newPerson.setValue(person.image?.pngData(), forKey: "image")
            newPerson.setValue(person.name, forKey: "name")
            newPerson.setValue(person.location, forKey: "location")
            newPerson.setValue(person.species, forKey: "species")
            newPerson.setValue(person.status, forKey: "status")
            newPerson.setValue(person.type, forKey: "type")
            newPerson.setValue(person.url, forKey: "url")
            
            do {
                try context.save()
            } catch {
                print("Failed saving '\(person.name)'")
            }
            
        }
        print("All characters was saved")
    }
    
    func loadPersonsFromDB(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonCD")
        do {
            var downloadedPersons = [Person]()
            let results = try context.fetch(request) as! [PersonCD]
            for result in results {
                let person = Person(personFromDB: result)
                downloadedPersons.append(person)
          }
            persons = downloadedPersons
        } catch {
            print("Failed")
        }
    }
    
    
    
}
