//
//  NewContactViewController.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/10/22.
//

import Foundation
import UIKit

class NewContactViewController: UIViewController{
    
    @IBOutlet weak var photoImageVIew: UIImageView!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    var viewModel: NewContactViewModel?
    
    override func viewDidLoad() {
        phoneNumberField.delegate = self
        createTable()
        photoImageVIew.makeRounded()
        firstNameTextField.becomeFirstResponder()
        
    }
    
    private func createTable(){
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let id = 0
        let firstName = firstNameTextField.text ?? ""
        let last = lastNameTextField.text ?? ""
        let phone = phoneNumberField.text ?? ""
        let imageV = photoImageVIew.image ?? UIImage(named: "person")
        guard let imageData = imageV?.pngData() else {return}
        
        let contactValues = Contacts(id: id, firstName: firstName, lastName: last, phoneNumber: phone, photo: imageData)
        
        createNewContact(contactValues)
        
        SQLiteCommands.presentRows()
    }
    
    //MARK: Create New Contact
    private func createNewContact(_ contactValues:Contacts){
        let newContactToAdd = SQLiteCommands.insertRow(contactValues)
        //Phonenumber is unique to all contacts so we check for if it already exists
        if newContactToAdd == true {
           dismiss(animated: true, completion: nil)
        }else{
            alert(title: "Error", message: "This contact cannot be added because it is already listed in the contacts.")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}

extension NewContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Image Tap Gesture
    @IBAction func addImageFromPhotoLibary(_ sender: Any) {
       // Lets user pick media from photo library.
        let imagePickerController = UIImagePickerController()
        //allows to pick photos
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictonrary decoding the image, recieved : \(info)")
        }
        photoImageVIew.image = image
        dismiss(animated: true, completion: nil)
    }
}

extension NewContactViewController: UITextFieldDelegate{
    
    private func format(with mask:String, phone:String)->String{

        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex{

            if ch == "X"{
                result.append(numbers[index])
                index = numbers.index(after: index)
            }else{
                result.append(ch)
            }
        }
        return numbers
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "(XXX) XXX-XXXX", phone: newString)
        return false
    }


}
