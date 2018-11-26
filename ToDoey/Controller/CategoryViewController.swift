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
    
    var catIndex : Int = 0
    let color = ["F36027","26BA0A","DC51E9","40C3E9","84150A","E2F600","7E58F8","E7580F"]

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
                    
                if (self.catIndex < 8)
                    {
                    newCategory.color = self.color[self.catIndex]
                    }
                else
                    {
                    newCategory.color = UIColor.randomFlat.hexValue()
                    }
                self.catIndex += 1

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
            catIndex -= 1
            }
        tableView.reloadData()
        }
    }
