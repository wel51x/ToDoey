//
//  DataModelUtil.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation
import RealmSwift

class RealmModelUtil
    {
    static var realm : Realm?
    
    static func initRealm()
        {
        do
            {
            realm = try Realm()
            }
        catch
            {
            print("Error creating Realm, \(error)")
            }
        }
    
    static func saveCategory(category : Category?)
    {
    do
        {
        try realm!.write
            {
            realm!.add(category!)
            }
        }
        catch
        {
        print("Error saving context, \(error)")
        }
    }
    
    static func loadCategories() -> Results<Category>?
        {
        return(realm?.objects(Category.self))
        }
    
    static func saveItem(item : Item?,
                         category : Category?)
        {
        do
            {
            try realm!.write
                {
                realm!.add(item!)
                category!.items.append(item!)
                }
            }
        catch
            {
            print("Error saving context, \(error)")
            }
        }
    
    static func loadItems(category : Category) -> Results<Item>?
        {
        return(category.items.sorted(byKeyPath: "title",
                                     ascending: true))
        }
    }
