//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Saidac Alexandru on 26.08.2022.
//

import UIKit

protocol TaskDelegate: AnyObject{
    func goToEditScreen(index: Int)
    func completeTask(atIndex index:Int)
}

class TaskTableViewCell: UITableViewCell {

   
    @IBOutlet weak var taskCompletionButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    weak var degelegate:TaskDelegate?
    var index: Int?
    

    
    @IBAction func modifyClickedButton(_ sender: Any) {
        guard let index = index else{
        return}
        degelegate?.goToEditScreen(index: index)
    }
    @IBAction func completionClickedButton(_ sender: Any) {
        guard let unwrappedIndex = index else{
            return
        }
        degelegate?.completeTask(atIndex: unwrappedIndex)
    }
}
