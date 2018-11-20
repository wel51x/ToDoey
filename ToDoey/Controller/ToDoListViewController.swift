//
//  ToDoListViewController.swift
//  ToDoey
//
//  Created by Winston Lee on 11/8/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController
    {
    var items : Results<Item>!
    
    var selectedCategory : Category?
        {
        didSet
            {
            items = RealmModelUtil.loadItems(category : selectedCategory!)!
            }
        }

    override func viewDidLoad()
        {
        super.viewDidLoad()
        }
    
    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
        {
        return items?.count ?? 1
        }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        if let item = items?[indexPath.row]
            {
            cell.textLabel?.text = item.title
            cell.accessoryType = (item.done) ? .checkmark : .none
            }
        else
            {
            cell.textLabel?.text = "No Items Added So Far"
            }

        return cell
        }
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
        {
        if let item = items?[indexPath.row]
            {
            RealmModelUtil.updateCheckBox(item: item)
            }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        }
    

    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
        {
        var addItemTextField = UITextField()

        let alert = UIAlertController(title: "Add ToDo Item",
                                      message: "",
                                      preferredStyle: .alert)
            
        let alertAction = UIAlertAction(title: "Add Item",
                                        style: .default)
            { (action) in
            // What happens when user clicks Add Item button on UIAlert
            if addItemTextField.text! != ""
                {
                if let currentCategory = self.selectedCategory
                    {
                    let newItem = Item()
                    newItem.title = addItemTextField.text!
//                    newItem.done = false  not needed - auto initialized
                    RealmModelUtil.saveItem(item: newItem,
                                            category: currentCategory)
                    }
                self.tableView.reloadData()
                }
            }
            
            alert.addTextField
                { (alertTextField) in
                alertTextField.placeholder = "New Item Name"
                addItemTextField = alertTextField
                }

        alert.addAction(alertAction)
            
        present(alert,
                animated: true,
                completion: nil)
        }
    }
