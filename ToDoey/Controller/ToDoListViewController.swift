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

    let defaults = UserDefaults.standard

    override func viewDidLoad()
        {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            itemArray.remove(at: 0)
            var newItem = Item()
            newItem.title = "Number One"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Number One"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Number One"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Number One"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Nummer Zwei"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Nummer Zwei"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Nummer Zwei"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Nummer Zwei"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Numero Tre"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Numero Tre"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Numero Tre"
            itemArray.append(newItem)
            newItem = Item()
            newItem.title = "Numero Tre"
            itemArray.append(newItem)
            if let items = ArchiveUtil.loadItems()
                {
                itemArray = items
                }
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
            
        ArchiveUtil.saveItems(Items: itemArray)
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
            print(addItemTextField.text!)
            if addItemTextField.text! != ""
                {
                let newItem = Item()
                newItem.title = addItemTextField.text!
                self.itemArray.append(newItem)
                    
                ArchiveUtil.saveItems(Items: self.itemArray)
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
