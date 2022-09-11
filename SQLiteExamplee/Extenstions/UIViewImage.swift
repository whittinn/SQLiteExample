//
//  UIViewImage.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import UIKit

extension UIImageView{
    
    // round shape corner
    
    func makeRounded(){
        
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}
