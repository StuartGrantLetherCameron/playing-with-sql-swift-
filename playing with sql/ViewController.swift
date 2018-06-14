//
//  ViewController.swift
//  playing with sql
//
//  Created by Stuart Cameron on 2018-06-10.
//  Copyright © 2018 Stuart Cameron. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection!
    
    let km_table = Table("km table")
    let entry_number = Expression<Int>("entry number")
    let km = Expression<Int>("Km")
    let gas = Expression<Double>("gas")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do{
            let dirctery = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                       appropriateFor: nil, create: true)
            let file_url = dirctery.appendingPathComponent("user").appendingPathExtension("sqlite3")
            let database = try Connection(file_url.path)
            self.database = database
        }catch{
            print(error)
        }
    }

    @IBAction func enter() {
    }
}

