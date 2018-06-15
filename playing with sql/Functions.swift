import SQLite3

class Functions {
    func get_all_from_table(db: OpaquePointer) {
        var stmt: OpaquePointer?
        
        var entry_list = [Entry]()
        let query = "SELECT * FROM km"
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            print("didnt prep")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let entry = sqlite3_column_int(stmt, 0)
            let km = sqlite3_column_int(stmt, 1)
            let gas = sqlite3_column_double(stmt, 2)
            
            entry_list.append(Entry(entry: Int(entry), km: Int(km), gas: Double(gas)))
            
            print("entry: ", entry, " km: ", km , " gas: ", gas)
        }
    }
}
