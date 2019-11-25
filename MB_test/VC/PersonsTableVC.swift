//
//  TableViewController.swift
//  MB_test
//
//  Created by Zayd on 21.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.

import UIKit

class PersonsTableVC: UITableViewController {
    var persons = [Person]()
    var dataModel:DataModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        persons = dataModel.persons
    }
    // MARK: - Private Methods
    
    func configurePersonInfo(for cell:UITableViewCell,
                             with person:Person){
        let personImageView = cell.viewWithTag(1) as! UIImageView
        let personNameLabel = cell.viewWithTag(2) as! UILabel
        
        personImageView.image = person.image
        personNameLabel.text = person.name
    }
    // MARK: - Table view data source
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        configurePersonInfo(for: cell, with: persons[indexPath.row])
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailInfo" {
            let person = sender as! Person
            let controller = segue.destination as! DetailInfoVC
            controller.person = person
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailInfo", sender: persons[indexPath.row])
    }
}
