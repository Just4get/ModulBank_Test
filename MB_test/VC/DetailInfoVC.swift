//
//  TextViewController.swift
//  MB_test
//
//  Created by Zayd on 24.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.
//

import UIKit

class DetailInfoVC: UIViewController {
    var person:Person!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personInfo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personImage.image = person.image
        personInfo.text = "Name: \(person.name)\n" +
            "Status: \(person.status)\n" +
            "Species: \(person.species)\n" +
            "Type: \(person.type)\n" +
            "Gender: \(person.gender)\n" +
            "Location: \(person.location)\n" +
            "Episodes: \(person.episode)\n" +
        "Created: \(person.created)\n"
        personInfo.isEditable = false
        
    }
}
