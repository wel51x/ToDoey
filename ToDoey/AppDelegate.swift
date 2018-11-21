//
//  AppDelegate.swift
//  ToDoey
//
//  Created by Winston Lee on 11/8/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
    {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                            launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
        {
        RealmModelUtil.initRealm()
            
        return true
        }

    func didFinishLaunching(_ application: UIApplication)
        {
        }

    func applicationWillTerminate(_ application: UIApplication)
        {
        }

    }
