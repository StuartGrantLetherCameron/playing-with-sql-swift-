import SQLite3
import UIKit
import Charts

class Functions {
    func get_all_from_table(db: OpaquePointer) -> [Entry] {
        var stmt: OpaquePointer?
        
        var entry_list = [Entry]()
        let query = "SELECT * FROM km"
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("didnt prep")
            return entry_list
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let entry = sqlite3_column_int(stmt, 0)
            let km = sqlite3_column_int(stmt, 1)
            let gas = sqlite3_column_double(stmt, 2)
            
            entry_list.append(Entry(entry: Int(entry), km: Int(km), gas: Double(gas)))
            
            print("entry: ", entry, " km: ", km , " gas: ", gas)
        }
        return entry_list
    }
    
    func add_gas(db : OpaquePointer, km_input: UITextField, gas_input: UITextField ) {
        var add: OpaquePointer?
        
        let add_query = "INSERT INTO gas_table (km, gas) VALUES (?,?)"
        
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
    }
    
    func set_chart(lineChartView: LineChartView){
        let values_entry = [13,45,33,67,7,28,85,6,10,18,22,16,13,24,44,88]
        let size = values_entry.count
        
        
        
        let values = (0...(size-1)).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(values_entry[i]))
        }
        
        let set1 = LineChartDataSet(values: values, label: "DataSet 1")
        let data = LineChartData(dataSet: set1)
        
        lineChartView.data = data
    }
    
    func delete_table(db: OpaquePointer) -> String {
        
        var delete: OpaquePointer?
        let delte_query = "DROP TABLE km_database.km"
        
        
        
        if sqlite3_prepare(db, delte_query, -1, &delete, nil) != SQLITE_OK{
            debugPrint("couldnt prep")
            return "failed :("
        }
        
        if sqlite3_step(delete) != SQLITE_DONE {
            print("didnt delte")
            return "didnt delte"
        }
        
        return "worked"
    }
    
    func add_to_empty(db: OpaquePointer) {
        var add: OpaquePointer?
        
        let add_query = "INSERT INTO gas_table (km, gas) VALUES (?,?)"
        
        if sqlite3_prepare(db, add_query, -1, &add, nil) != SQLITE_OK{
            debugPrint("couldnt prep")
            return
        }
        
        if sqlite3_bind_int(add, 1, 0) != SQLITE_OK{
            debugPrint("could bind km")
            return
        }
        
        if sqlite3_bind_double(add, 2, Double(0)) != SQLITE_OK{
            debugPrint("could bind gas")
            return
        }
        
        if sqlite3_step(add) != SQLITE_DONE{
            print("couldnt added")
            return
        }else{
            debugPrint("added")
        }
    }
}
