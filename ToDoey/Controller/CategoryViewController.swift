//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Winston Lee on 11/16/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController
    {
    var categories : Results<Category>?
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
            
        categories = RealmModelUtil.loadCategories()
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
                let newCategory = Category()
                    
                newCategory.name = addCategoryTextField.text!
                newCategory.color = UIColor.randomFlat.hexValue()
                    
                RealmModelUtil.saveCategory(category: newCategory)
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
        performSegue(withIdentifier: "goToItems",
                     sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
        {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
            {
            destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }

    //MARK - Tableview DataSource methods
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
        {
        return categories?.count ?? 1
        }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        let cell = super.tableView(tableView,
                                   cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added So Far"
        cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color)!) ?? UIColor.randomFlat
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!,
                                                    returnFlat: true)
                        
        return cell
        }
    
    override func deleteRowFromModel(at indexPath: IndexPath)
        {
        if let currentCategory = self.categories?[indexPath.row]
            {
            RealmModelUtil.deleteCategory(category: currentCategory)
            }
        tableView.reloadData()
        }
    }
