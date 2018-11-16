//
//  DataModelUtil.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataModelUtil
    {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static func saveItems(Items : [Item]?)
        {
        do
            {
            try context.save()
            }
        catch
            {
            print("Error saving context, \(error)")
            }
        }
    
    static func loadItems(category : Category) -> [Item]?
        {
        var itemArray  = [Item()]
        itemArray.removeAll()
            
        let request : NSFetchRequest<Item> = Item.fetchRequest()

        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@",
                                    category.name!)
        request.predicate = predicate
        
        do
            {
            itemArray = try context.fetch(request)
            }
            catch
            {
            print("Error loading itemArray, \(error)")
            }
        return(itemArray)
        }
 
    static func saveCategories(Categories : [Category]?)
        {
        do
            {
            try context.save()
            }
        catch
            {
            print("Error saving context, \(error)")
            }
        }
    
    static func loadCategories() -> [Category]?
        {
        var categoryArray  = [Category()]
        categoryArray.removeAll()
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do
            {
            categoryArray = try context.fetch(request)
            }
        catch
            {
            print("Error loading itemArray, \(error)")
            }
        return(categoryArray)
        }
   }
