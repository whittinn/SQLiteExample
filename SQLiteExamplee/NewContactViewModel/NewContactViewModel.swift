//
//  NewContactViewModel.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import UIKit

class NewContactViewModel{
    
    private var contactValue: Contacts?
    
    let id: Int?
    let firstName: String?
    let lastName: String?
    let photoNumber: String?
    let photo: UIImage?
    
    init(contactValues:Contacts?){
        self.contactValue = contactValues
        self.id = contactValues?.id
        self.firstName = contactValues?.firstName
        self.lastName = contactValues?.lastName
        self.photo = UIImage(data: contactValues!.photo)
        self.photoNumber = contactValues?.phoneNumber
    }
}
