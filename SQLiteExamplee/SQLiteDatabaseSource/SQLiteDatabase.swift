//
//  SQLiteDatabase.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import SQLite

class SQLiteDatabase{
    
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init(){
        //create connection to database
        do{
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            database = try Connection("\(path)/db.sqlite3")
        }catch{
            print("Error creating connection to database: \(error)")
        }
        
    }
    
    func createTable(){
        SQLiteCommands.createTable()
    }
}
