//
//  CoreDataUtil.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataUtil
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
    
    static func loadItems() -> [Item]?
        {
        var itemArray  = [Item()]
        itemArray.removeAll()
        let request : NSFetchRequest<Item> = Item.fetchRequest()
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
/*
    static func loadItems() -> [Item]?
        {
        if let data = try? Data(contentsOf: CoreDataUtil.dataFilePath!)
            {
            let decoder = PropertyListDecoder()
            do
                {
                return(try decoder.decode([Item].self, from: data))
                }
            catch
                {
                print("Error decoding itemArray, \(error)")
                }
            }
        var itemArray = [Item()]
        itemArray.removeAll()
        return(itemArray)
        }
 */
    }
