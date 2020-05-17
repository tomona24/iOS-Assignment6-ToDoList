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
    func edit(task: Task)
}

class AddToDoTableViewController: UITableViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    private var isEdit = false
    private var taskName : String?
    
    weak var delegate: AddToDoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        if let newTaskName = textField.text {
            if isEdit && ((textField.text?.isEmpty) != nil) {
                saveButton.isEnabled = true
            } else {
                if newTaskName == taskName {
                    saveButton.isEnabled = true
                }
            }
        }
    }
    
    func textFieldShouldReturn (_ tf :UITextField) -> Bool {
        textField.resignFirstResponder()
        updateSaveButtonState()
        return true
    }
    
    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        if isEdit != false {
            delegate?.add(task: Task(name: textField.text!))
        } else {
            delegate?.edit(task: Task(name: textField.text!))
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
