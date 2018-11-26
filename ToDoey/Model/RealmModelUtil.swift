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
//            Realm.Configuration.defaultConfiguration.schemaVersion = 1
//                  don't need to do this - just delete app
            realm = try Realm()
            }
        catch
            {
            print("Error creating Realm, \(error)")
/*
            // upgrade if nec.
            let config = Realm.Configuration(
                // Set the new schema version. This must be greater than the previously used
                // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
                    
                // Set the block which will be called automatically when opening a Realm with
                // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                    // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1)
                    {
                        // Nothing to do!
                        // Realm will automatically detect new properties and removed properties
                        // And will update the schema on disk automatically
                    }
                })
                
                // Tell Realm to use this new configuration object for the default Realm
            Realm.Configuration.defaultConfiguration = config
                
                // Now that we've told Realm how to handle the schema change, opening the file
                // will automatically perform the migration
            realm = try! Realm()
 */
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
            print("Error saving Category, \(error)")
            }
        }
    
    static func deleteCategory(category : Category?)
        {
        do
            {
            try realm!.write
                {
                realm?.delete(category!.items)  // first delete category's items
                realm?.delete(category!)
                }
            }
        catch
            {
            print("Error deleting Category, \(error)")
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
            print("Error saving Item, \(error)")
            }
        }
    
    static func updateCheckBox(item : Item?)
        {
        do
            {
            try realm!.write
                {
//                realm?.delete(item)     // do this instaed of next statement if prefer to delete item
                item!.done = !item!.done  // flip checkmark
                realm!.add(item!)
                }
            }
        catch
            {
            print("Error updating check box Item, \(error)")
            }
        }

    static func loadItems(category : Category) -> Results<Item>?
        {
        return(category.items.sorted(byKeyPath: "title",
                                     ascending: true))
        }
    
    static func deleteItem(item : Item?)
        {
        do
            {
            try realm!.write
                {
                realm?.delete(item!)
                }
            }
        catch
            {
            print("Error deleting Item, \(error)")
            }
        }
    }
