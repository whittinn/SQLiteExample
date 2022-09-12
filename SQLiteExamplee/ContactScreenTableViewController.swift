//
//  ContactScreenTableViewController.swift
//  SQLiteExamplee
//
//  Created by Nathaniel Whittington on 9/11/22.
//

import UIKit

class ContactScreenTableViewController: UITableViewController {

    private var viewModel = ContactScreenViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Contacts"
        
        //connect to databse
        viewModel.contactToDatabase()
    }

//MARK: Load data from SQLdatabase
    private func loadData(){
        viewModel.loadSQLDatabase()
    }
    
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSectino(section: section)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let object = viewModel.cellForRowAt(index: indexPath)
        if let contactCell = cell as? ContactScreenTableViewCell{
            contactCell.setCellContactValues(object)
        }

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "editContact"{
            guard let newVc = segue.destination as? NewContactViewController else {return}
            guard let selectedContactCell = sender as? ContactScreenTableViewCell else {return}
            if let indexPath = tableView.indexPath(for: selectedContactCell){
                let selectedContact = viewModel.cellForRowAt(index: indexPath)
                newVc.viewModel = NewContactViewModel(contactValues: selectedContact)
            }
        }
    }
    

}
