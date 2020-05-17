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

class AddToDoTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    private var isEdit = false
    private var taskName : String?
    
    weak var delegate: AddToDoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        updateSaveButtonState()
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
        let newTask = Task(name: name)
        if isEdit {
            delegate?.edit(task: newTask)
        } else {
            delegate?.add(task: newTask)
        }
        self.navigationController?.popViewController(animated: true)
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
