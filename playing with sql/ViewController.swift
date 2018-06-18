//
//  ViewController.swift
//  playing with sql
//
//  Created by Stuart Cameron on 2018-06-10.
//  Copyright © 2018 Stuart Cameron. All rights reserved.
//

import UIKit
import SQLite3
import Charts

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var km_input: UITextField!
    @IBOutlet weak var gas_input: UITextField!
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        let dirctery = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                       appropriateFor: nil, create: false).appendingPathComponent("km_database.sqlite")
        
        
        if sqlite3_open(dirctery.path, &db) != SQLITE_OK{
            print("error loading db")
        }
        
        let createTable = "CREATE TABLE IF NOT EXISTS gas_table (entry INTEGER PRIMARY KEY AUTOINCREMENT, km INTEGER, gas REAL)"
        
        if sqlite3_exec(db, createTable, nil, nil, nil) != SQLITE_OK{
            print("couldnt create table")
        }
        
        print(Functions().delete_table(db: db!))
        
        debugPrint("everything worked !!!")
        if lineChartView != nil{
            Functions().set_chart(lineChartView: lineChartView)
        }
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    @IBAction func enter_gas() {
        Functions().add_gas(db: db!, km_input: km_input, gas_input: gas_input)
    }
}

