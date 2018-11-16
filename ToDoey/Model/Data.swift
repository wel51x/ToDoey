//
//  Data.swift
//  ToDoey
//
//  Created by Winston Lee on 11/16/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object
    {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
    }
