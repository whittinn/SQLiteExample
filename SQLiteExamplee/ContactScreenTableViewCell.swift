//
//  NewContactTableViewCell.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import UIKit

class ContactScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactImageLabel: UIImageView!
    
  //setup contact values
    func setCellContactValues(_ contact:Contacts){
        
        contactNameLabel.text = contact.firstName + "" + contact.lastName
        contactNumberLabel.text = contact.phoneNumber
        let image = UIImage(data: contact.photo)
        contactImageLabel.image = image
        contactImageLabel.makeRounded()
        
    }

}
