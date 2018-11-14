//
//  ArchiveUtil.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation

class ArchiveUtil
    {
    
    private static let ItemsKey = "ToDoListArray"
    
    private static func archiveItems(Items : [Item]) -> NSData
        {
        
        return NSKeyedArchiver.archivedData(withRootObject: Items as NSArray) as NSData
        }
    
    static func loadItems() -> [Item]?
        {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: ItemsKey) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Item]
        }
        
        return nil
        }
    
    static func saveItems(Items : [Item]?)
        {
        let archivedObject = archiveItems(Items: Items!)
        UserDefaults.standard.set(archivedObject, forKey: ItemsKey)
        UserDefaults.standard.synchronize()
        }
    
    }
