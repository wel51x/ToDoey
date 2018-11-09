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
    var itemArray = ["Number One", "Nummer Zwei", "Numero Tre"]

    override func viewDidLoad()
        {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
        }
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
        {
        // print(itemArray[indexPath.row])
            
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
            {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        else
            {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
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
            print(addItemTextField.text!)
            if addItemTextField.text! != ""
                {
                self.itemArray.append(addItemTextField.text!)
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
