//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Winston Lee on 11/16/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController
    {
    var categoryArray = [Category()]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad()
        {
        super.viewDidLoad()
            
        if let categories = CoreDataUtil.loadCategories()
            {
            categoryArray = categories
            }

        }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
        {
        var addCategoryTextField = UITextField()
            
        let alert = UIAlertController(title: "Add Category",
                                      message: "",
                                      preferredStyle: .alert)
            
        let alertAction = UIAlertAction(title: "Add Category",
                                        style: .default)
            { (action) in
                // What happens when user clicks Add Category button on UIAlert
            if addCategoryTextField.text! != ""
                {
                let newCategory = Category(context: self.context)
                    
                newCategory.name = addCategoryTextField.text!
                self.categoryArray.append(newCategory)
                    
                CoreDataUtil.saveCategories(Categories: self.categoryArray)
                self.tableView.reloadData()
                }
            }
            
        alert.addTextField
            { (alertTextField) in
                alertTextField.placeholder = "New Category Name"
                addCategoryTextField = alertTextField
            }
            
        alert.addAction(alertAction)
            
        present(alert,
                animated: true,
                completion: nil)
        }
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
        {
        }

    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
        {
        return categoryArray.count
        }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",
                                                 for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        }

    //MARK - Data Manipulation methods

    }
