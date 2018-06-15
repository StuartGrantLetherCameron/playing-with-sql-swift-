//
//  ViewController.swift
//  playing with sql
//
//  Created by Stuart Cameron on 2018-06-10.
//  Copyright © 2018 Stuart Cameron. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var gas_input: UITextField!
    @IBOutlet weak var km_input: UITextField!
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gas_input.delegate = self
        self.km_input.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
      
        let dirctery = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                       appropriateFor: nil, create: false).appendingPathComponent("km_database.sqlite")
        
        
        if sqlite3_open(dirctery.path, &db) != SQLITE_OK{
            print("error loading db")
        }
        
        let createTable = "CREATE TABLE IF NOT EXISTS km (entry INTEGER PRIMARY KEY AUTOINCREMENT, km INTEGER, gas REAL)"
        
        if sqlite3_exec(db, createTable, nil, nil, nil) != SQLITE_OK{
            print("couldnt create table")
        }
        
        debugPrint("everything worked !!!")
    }
    
    
    
    @IBAction func add_info() {
        
        var add: OpaquePointer?
        
        let add_query = "INSERT INTO km (km, gas) VALUES (?,?)"
        
        if sqlite3_prepare(db, add_query, -1, &add, nil) != SQLITE_OK{
            debugPrint("couldnt prep")
        }
        
        if sqlite3_bind_int(add, 1, Int32(km_input.text!)!) != SQLITE_OK{
            debugPrint("could bind km")
        }
        
        if sqlite3_bind_double(add, 2, Double(gas_input.text!)!) != SQLITE_OK{
            debugPrint("could bind gas")
        }
        
        if sqlite3_step(add) != SQLITE_DONE{
            debugPrint("couldnt add")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
}

