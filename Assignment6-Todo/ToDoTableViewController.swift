//
//  ToDoTableViewController.swift
//  Assignment6-Todo
//
//  Created by Tomona Sako on 2020/05/14.
//  Copyright © 2020 Tomona Sako. All rights reserved.
//

import UIKit

protocol toDoTableViewControllerDelegate: class {
    func sendEdit(task: Task)
}


class ToDoTableViewController: UITableViewController, AddToDoTableViewControllerDelegate {
    
    private let secs =  ["High", "Middle", "Low"]
    private var tasks:[[Task]] = [[],[],[]]
    
    weak var delegate: toDoTableViewControllerDelegate?
    
    private var editingTask: Task!
    
    private var editingIndexPath: IndexPath = []
    
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddToDoTableViewController
        if segue.identifier == "editTask" {
            destVC.isEdit = true
            destVC.editingTask = self.editingTask
            destVC.editingIndex = self.editingIndexPath
        }
        destVC.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secs[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        let task = tasks[indexPath.section][indexPath.row]
        let doneLabel = cell.viewWithTag(1) as! UILabel
        if !tasks.isEmpty {
            if !task.done {
                doneLabel.isHidden = true
            } else {
                doneLabel.isHidden = false
            }
            cell.TaskTitleLabel.text = task.name
        }
        return cell
    }
    
    // from AddToDoTableViewControllerDelegate
    func add(task: Task) {
        tasks[1].append(task)
        tableView.reloadData()
        
        // Error happen
        // tableView.insertRows(at: [IndexPath(row: tasks[1].count - 1 , section: 1)], with: .automatic)
    }
    
    
    // from AddToDoTableViewControllerDelegate
    func edit(task: Task, indexPath: IndexPath) {
        tasks[indexPath.section][indexPath.row] = task
        tableView.reloadData()
        // Error happen
        // tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard !tableView.isEditing else {
            return
        }
        
        editingTask = tasks[indexPath.section][indexPath.row]
        editingIndexPath = indexPath
        performSegue(withIdentifier: "editTask", sender: nil)
    }
    
    
    // done
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !tableView.isEditing else {
            return
        }
        let isDone = tasks[indexPath.section][indexPath.row].done
        tasks[indexPath.section][indexPath.row].done = !isDone
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    

    // move
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if tableView.isEditing {
            let taskToMove = tasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            tasks[destinationIndexPath.section].insert(taskToMove, at: destinationIndexPath.row)
            tableView.reloadData()
        }
    }
    
    // delete
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
    

    
}
