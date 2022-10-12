//
//  TaskEditViewController.swift
//  ToDoList
//
//  Created by Saidac Alexandru on 01.09.2022.
//

import UIKit

protocol TaskEditDelegate: AnyObject{
    func passCellModification(taskName:String, taskDescription:String , taskCompletion: Bool, index: Int)
}

class TaskEditViewController: UIViewController {
    
    var task:Task?
    var index:Int?

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var taskCompletionSwitch: UISwitch!
    weak var delegate:TaskEditDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let task = task {
            taskNameTextField.text = task.taskName
            taskDescriptionTextField.text = task.taskDescription
            taskCompletionSwitch.isOn = task.isCompleted
        }

    }
    

    @IBAction func taskCompletionSwitchTaped(_ sender: Any) {
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let task = task, let index = index else{
            return
        }
        guard let unwrappedTaskName = taskNameTextField.text, let unwrappedDescription = taskDescriptionTextField.text else{
            return
        }
        RealmDataBaseManager.shared.update(id: task.id, name: unwrappedTaskName, description: unwrappedDescription , isComplete: task.isCompleted)
        delegate?.passCellModification(taskName: unwrappedTaskName, taskDescription: unwrappedDescription, taskCompletion: taskCompletionSwitch.isOn, index: index)
        navigationController?.popToRootViewController(animated: true)
    }
}
