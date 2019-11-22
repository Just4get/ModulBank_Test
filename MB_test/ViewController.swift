//
//  ViewController.swift
//  MB_test
//
//  Created by Zayd on 20.11.2019.
//  Copyright © 2019 Zayd. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {
    var person:Person!
    
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    
    
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

