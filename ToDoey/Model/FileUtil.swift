//
//  FileUtil.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation

class FileUtil
    {
    public static let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    static func saveItems(Items : [Item]?)
        {
        let encoder = PropertyListEncoder()
            
        do
            {
            let data = try encoder.encode(Items)
            try data.write(to: FileUtil.dataFilePath!)
            }
        catch
            {
            print("Error encoding itemArray")
            }
        }
    
    static func loadItems() -> [Item]?
        {
        if let data = try? Data(contentsOf: FileUtil.dataFilePath!)
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
    }
