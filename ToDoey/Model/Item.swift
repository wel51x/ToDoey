//
//  Item.swift
//  ToDoey
//
//  Created by Winston Lee on 11/16/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object
    {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType : Category.self,
                                        property : "items")
    }
