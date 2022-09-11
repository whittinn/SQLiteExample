//
//  SQLiteCommands.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import SQLite
import SQLite3

class SQLiteCommands{
    
    static var table = Table("contact")
    
    //Expressions
    static let id = Expression<Int>("id")
    static let firstName = Expression<String>("firstName")
    static let lastName = Expression<String>("lastName")
    static let phoneNumber = Expression<String>("phoneNumber")
    static let photo = Expression<Data>("photo")
    
    //create table
    static func createTable(){
        
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("database failed to connect")
            return
        }
        
        do{
            //ifNotExists : True - Will Not Create Table if it alreay exists
            try database.run(table.create(ifNotExists:true){ table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(phoneNumber, unique: true)
                table.column(photo)
                
            })
        }catch{
            print("table already exists \(error)")
        }
              
    }
    
    // insert row
    static func insertRow(_ contactValues: Contacts)->Bool?{
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("error connecting to database")
            return nil
        }
        
        do{
            try database.run(table.insert(firstName <- contactValues.firstName, lastName <- contactValues.lastName, photo <- contactValues.photo, phoneNumber <- contactValues.phoneNumber))
            return true
        }catch let Result.error(message: message, code: code, statement: statement) where code == SQLITE_CONSTRAINT{
            print("Insert row failed: \(message) in \(String(describing: statement))")
            return false
        }catch let error{
            print("insert failed : \(error)")
            return false
        }
    }
    
    static func presentRows()-> [Contacts]?{
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("error connecting to database")
            return nil
        }
        //Contact Array
        var contactArray = [Contacts]()
        //sort data descening in order by id
        table = table.order(id.desc)
        
        do{
            for contact in try database.prepare(table) {
                let idValue = contact[id]
                let firstNameValue = contact[firstName]
                let lastNameValue = contact[lastName]
                let phoneNumberValue = contact[phoneNumber]
                let photoValue = contact[photo]
                
                //create object
                let contentObject = Contacts(id: idValue, firstName: firstNameValue, lastName: lastNameValue, phoneNumber: phoneNumberValue, photo: photoValue)
                
                //add object to an array
                contactArray.append(contentObject)
                
                print("id: \(contact[id]), firstName: \(contact[firstName]), lastName: \(contact[lastName]), phonoNumber: \(contact[phoneNumber]), photo: \(contact[photo])")
            }
            
        }catch{
            print("error presenting row: \(error)")
            
        }
        return contactArray
    }
}
