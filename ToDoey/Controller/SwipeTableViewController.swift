//
//  SwipeTableViewController.swift
//  ToDoey
//
//  Super class for when want to swipe delete on both categories and items screens
//
//  Created by Winston Lee on 11/20/18.
//  Copyright © 2018 Tahoe Software. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController,
                                SwipeTableViewCellDelegate
    {

    override func viewDidLoad()
        {
        super.viewDidLoad()
        }

    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! SwipeTableViewCell            
        cell.delegate = self
        return cell
        }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]?
        {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive,
                                       title: "Delete")
            { action, indexPath in
                self.deleteRowFromModel(at: indexPath)
            }
        
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
        }
    
    func deleteRowFromModel(at indexPath: IndexPath)
        {
        //Update Data Model
        }
    }
