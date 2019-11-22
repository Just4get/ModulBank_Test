//
//  TableViewController.swift
//  MB_test
//
//  Created by Zayd on 21.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var persons = [Person]()
    var dataModel:DataModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persons = dataModel.persons
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Private Methods
    
    func configurePersonInfo(for cell:UITableViewCell,
                             with person:Person){
        let personImageView = cell.viewWithTag(1) as! UIImageView
        let personNameLabel = cell.viewWithTag(2) as! UILabel
        let personIdLabel = cell.viewWithTag(3) as! UILabel
        let personGenderLabel = cell.viewWithTag(4) as! UILabel
        let personTypeLabel = cell.viewWithTag(5) as! UILabel
        let personStatusLabel = cell.viewWithTag(6) as! UILabel
        
        personImageView.image = person.image
        personNameLabel.text = person.name
        personIdLabel.text = "ID: \(person.id)"
        personGenderLabel.text = "Пол: \(person.gender)"
        personTypeLabel.text = "Вид: \(person.type)"
        personStatusLabel.text = "Статус: \(person.status)"
        
        print("Собрал cell для \(person.name)")
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        configurePersonInfo(for: cell, with: persons[indexPath.row])
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailInfo" {
            let person = sender as! Person
            let controller = segue.destination as! ViewController
            controller.person = person
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailInfo", sender: persons[indexPath.row])
    }
}
