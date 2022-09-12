//
//  ContactScreenViewModel.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/11/22.
//

import Foundation

class ContactScreenViewModel{
    
    private var contactArray = [Contacts]()
    
    func contactToDatabase(){
        
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadSQLDatabase(){
        contactArray = SQLiteCommands.presentRows() ?? []
    }
    
    func numberOfRowsInSectino(section:Int)->Int{
        
        if contactArray.count != 0 {
            return contactArray.count
        }
        return 0
    }
    
    func cellForRowAt(index:IndexPath)-> Contacts{
        return contactArray[index.row]
    }
}
