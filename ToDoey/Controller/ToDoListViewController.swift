//
//  ViewController.swift
//  ToDoey
//
//  Created by Winston Lee on 11/8/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController
    {
    var itemArray = [Item()]
    
    var selectedCategory : Category?
        {
        didSet
            {
            itemArray = DataModelUtil.loadItems(category : selectedCategory!)!
            }
        }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad()
        {
        super.viewDidLoad()
        }
    
    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
        {
        return itemArray.count
        }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",
                                                 for: indexPath)
        let item = itemArray[indexPath.row]
            
        cell.textLabel?.text = item.title
            
        cell.accessoryType = (item.done) ? .checkmark : .none

        return cell
        }
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
        {
// if want to delete row rather than just set checkmark
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
            
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // flip checkmark
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
            
        DataModelUtil.saveItems(Items: itemArray)
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
                let newItem = Item(context: self.context)
                    
                newItem.title = addItemTextField.text!
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                self.itemArray.append(newItem)
                    
                DataModelUtil.saveItems(Items: self.itemArray)
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
