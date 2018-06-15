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

    
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    @IBOutlet weak var km_input: UITextField!
    @IBOutlet weak var gas_input: UITextField!
    
    
    
    @IBAction func add_info(_ sender: Any) {
        var add: OpaquePointer?
        
        let add_query = "INSERT INTO km (km, gas) VALUES (?,?)"
        
        if sqlite3_prepare(db, add_query, -1, &add, nil) != SQLITE_OK{
            debugPrint("couldnt prep")
            return
        }
        
        if sqlite3_bind_int(add, 1, Int32(km_input.text!)!) != SQLITE_OK{
            debugPrint("could bind km")
            return
        }
        
        if sqlite3_bind_double(add, 2, Double(gas_input.text!)!) != SQLITE_OK{
            debugPrint("could bind gas")
            return
        }
        
        if sqlite3_step(add) != SQLITE_DONE{
            print("couldnt added")
            return
        }else{
            debugPrint("added")
        }
        
        print()
        print()
        
        var entry_list = [Entry]()
        let query = "SELECT * FROM km"
        
        if sqlite3_prepare(db, query, -1, &add, nil) != SQLITE_OK{
            print("didnt prep")
            return
        }
        
        while(sqlite3_step(add) == SQLITE_ROW){
            let entry = sqlite3_column_int(add, 0)
            let km = sqlite3_column_int(add, 1)
            let gas = sqlite3_column_double(add, 2)
            
            entry_list.append(Entry(entry: Int(entry), km: Int(km), gas: Double(gas)))
            
            print("entry: ", entry, " km: ", km , " gas: ", gas)
        }
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
}

