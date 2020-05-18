//
//  AddToDoTableViewController.swift
//  Assignment6-Todo
//
//  Created by Tomona Sako on 2020/05/14.
//  Copyright © 2020 Tomona Sako. All rights reserved.
//

import UIKit

protocol AddToDoTableViewControllerDelegate: class {
    func add(task: Task)
    func edit(task: Task, indexPath: IndexPath)
}

class AddToDoTableViewController: UITableViewController, UITextFieldDelegate, toDoTableViewControllerDelegate {
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var isEdit = false
    
    var editingTask : Task!
    var editingIndex: IndexPath!
    
    weak var delegate: AddToDoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if isEdit {
            navigationItem.title = "Edit item"
            textField.text = editingTask.name
        } else {
            navigationItem.title = "Add item"
        }
    }
    
    private func updateSaveButtonState() {
        let newTaskName = textField.text ?? ""
        saveButton.isEnabled = (isEdit && !newTaskName.isEmpty) ||
            (!isEdit && !newTaskName.isEmpty)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateSaveButtonState()
        return true
    }
    
    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        let name = textField.text ?? ""
        if isEdit {
            editingTask.name = name
            delegate?.edit(task: editingTask, indexPath: editingIndex)
        } else {
            let newTask = Task(name: name)
            delegate?.add(task: newTask)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // from ToDoTableViewControllerDelegate
    func sendEdit(task: Task) {
        
    }    
}
