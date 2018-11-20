//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Winston Lee on 11/16/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController
    {
    var categories : Results<Category>?
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
            
        categories = RealmModelUtil.loadCategories()
            
        tableView.rowHeight = 60.0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",
                                                 for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added So Far"
            
        cell.delegate = self
            
        return cell
        }
    }

//MARK - Swipe Cell Delegate methods

extension CategoryViewController: SwipeTableViewCellDelegate
    {
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]?
        {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive,
                                       title: "Delete")
            { action, indexPath in
            // handle action by updating model with deletion
            if let currentCategory = self.categories?[indexPath.row]
                {
                RealmModelUtil.deleteCategory(category: currentCategory)
                }
//            print("item deleted")
            tableView.reloadData()
            }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    }
