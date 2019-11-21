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

    @IBAction func getData(_ sender: UIButton) {
        let baseURL = URL(string: "https://rickandmortyapi.com/api/character/")!
        let task = URLSession.shared.dataTask(with: baseURL) {(data, response, error) in
            guard let data = data else { return }
            
            if let json = try? JSON(data: data){
                print(json)
            }
            
            //print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        //let json = JSON(data: datajs!)
    }
    @IBOutlet weak var contentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

