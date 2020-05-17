//
//  ToDoTableViewController.swift
//  Assignment6-Todo
//
//  Created by Tomona Sako on 2020/05/14.
//  Copyright © 2020 Tomona Sako. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, AddToDoTableViewControllerDelegate {
    
    var secs =  ["high", "middle", "low"]
    var tasks = [
        [Task(name: "A"), Task(name: "B")],
        [Task(name: "C") ],
        [Task(name: "D") ]
    ]
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddToDoTableViewController
        destVC.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secs[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        let task = tasks[indexPath.section][indexPath.row]
        let doneLabel = cell.viewWithTag(1) as! UILabel
        if !task.done {
            doneLabel.isHidden = true
        } else {
            doneLabel.isHidden = false
        }
        cell.TaskTitleLabel.text = task.name
        return cell
    }
    
    // from AddToDoTableViewControllerDelegate
    func add(task: Task) {
        tasks[1].append(task)
        tableView.reloadData()
        
        // Warning happen, but following works as well.
        //        tableView.insertRows(at: [IndexPath(row: tasks[1].count - 1 , section: 1)], with: .automatic)
    }
    
    // from AddToDoTableViewControllerDelegate
    func edit(task: Task) {
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if !tableView.isEditing {
            let isDone = tasks[indexPath.section][indexPath.row].done
            tasks[indexPath.section][indexPath.row].done = !isDone
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if tableView.isEditing {
            let taskToMove = tasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            tasks[destinationIndexPath.section].insert(taskToMove, at: destinationIndexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func deleteSelectedRows(_ sender: UIBarButtonItem) {
        let selectedRows = tableView.indexPathsForSelectedRows ?? []
        if tableView.isEditing && !selectedRows.isEmpty {
            let sortedRows = selectedRows.sorted{ $0.row > $1.row }.sorted{$0.section > $1.section}
            for indexPath in sortedRows {
                tasks[indexPath.section].remove(at: indexPath.row)
            }
            tableView.deleteRows(at: sortedRows, with: .automatic)
        }
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
