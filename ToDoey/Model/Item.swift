//
//  Item.swift
//  ToDoey
//
//  Created by Winston Lee on 11/13/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation

class Item : NSObject, NSCoding, Codable
{
    var title : String = ""
    var done : Bool = false

    required init(coder aDecoder: NSCoder)
        {
        title = (aDecoder.decodeObject(forKey: "title") as? String)!
        done = aDecoder.decodeBool(forKey: "done")
        }
    
    public func encode(with aCoder: NSCoder)
        {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(done, forKey: "done")
        }
    
    override init()
        {
        super.init()
        }
    }
