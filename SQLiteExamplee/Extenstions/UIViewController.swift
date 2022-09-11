//
//  UIViewController.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func alert(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
