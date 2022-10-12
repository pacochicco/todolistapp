//
//  ViewController.swift
//  ToDoList
//
//  Created by Saidac Alexandru on 25.08.2022.
//

import UIKit
import RealmSwift


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , TaskDelegate , TaskEditDelegate{

    @IBOutlet weak var tableView: UITableView!
    var tasks:[Task] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadDataFromRealm()
        // Do any additional setup after loading the view.
    }
    
    func loadDataFromRealm(){
        tasks = RealmDataBaseManager.shared.read()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue"{
            guard let taskIndex = sender as? Int else{
                return
            }
            let destinationVC = segue.destination as! TaskEditViewController
            destinationVC.task = tasks[taskIndex]
            destinationVC.index = taskIndex
            destinationVC.delegate = self
        }
    }
    func completeTask(atIndex index: Int) {
        tasks[index].toggleCompletion()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            RealmDataBaseManager.shared.delete(id: tasks[indexPath.row].id )
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCustomCell") as! TaskTableViewCell
        let task = tasks[indexPath.row]
        let dateformatted = task.date.formatted(date: .numeric, time: .omitted)
        cell.titleLabel.text = task.taskName
        cell.decriptionLabel.text = task.taskDescription
        cell.dateLabel.text = "\(dateformatted)"
        cell.degelegate = self
        cell.index = indexPath.row
        cell.selectionStyle = .none
        if task.isCompleted{
            cell.taskCompletionButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            RealmDataBaseManager.shared.update(id: task.id, name: task.taskName , description: task.taskDescription, isComplete: true)
        }else {
            cell.taskCompletionButton.setImage(UIImage(systemName: "circle"), for: .normal)
            RealmDataBaseManager.shared.update(id: task.id, name: task.taskName , description: task.taskDescription, isComplete: false)
        }
        return cell
//        if indexPath.row % 2 == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCustomCell") as! TaskTableViewCell
//            let task = tasks[indexPath.row]
//            cell.titleLabel.text = task.taskName
//            cell.decriptionLabel.text = task.taskDescription
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")!
//            let task = tasks[indexPath.row]
//            cell.textLabel?.text = task.taskName
//            cell.detailTextLabel?.text = task.taskDescription
//            return cell
//
//        }
        
//        if task.isCompleted{
//            cell?.accessoryType = .checkmark
//        }else {
//            cell?.accessoryType = .none
//        }
    }
//    func updateTask(name: String, description: String, isComplete:Bool, index: Int){
//        tasks[index].taskName = name
//        tasks[index].taskDescription = description
//        tasks[index].isCompleted = isComplete
//    }
    func passCellModification(taskName: String, taskDescription: String, taskCompletion: Bool,index:Int) {
        tasks[index].taskName = taskName
        tasks[index].taskDescription = taskDescription
        tasks[index].isCompleted = taskCompletion
        self.tableView.reloadData()
    }
    
    func goToEditScreen(index: Int){
        performSegue(withIdentifier: "EditSegue", sender: index)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tasks[indexPath.row].toggleCompletion()
//        tableView.reloadData()
//    }
      //  if tasks[indexPath.row].isCompleted{
        //    tasks[indexPath.row].isCompleted = false
        //} else {
          //  tasks[indexPath.row].isCompleted = true
    //}
    //    tableView.reloadData()
   // }
    
    @IBAction func plusButtonDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "New Task", message: "Alert", preferredStyle: .alert)
        alert.addTextField{ textfield in textfield.placeholder = "Task Name"
        }
        alert.addTextField{
            textfield in textfield.placeholder = "Task Description"
        }
        let action = UIAlertAction(title: "Submit", style: .default){
            action in
            if let textfields  = alert.textFields{
                let taskNameTextField = textfields[0]
                let taskName = taskNameTextField.text
                let textDescriptionTextField = textfields[1]
                let taskDescription =
                textDescriptionTextField.text
                guard let taskNameText = taskName ,let taskDescriptionText = taskDescription,taskNameText.count >= 3, taskDescriptionText.count >= 5 else {
                    return
                }
                    
                let task = Task(id:UUID().uuidString, taskName: taskNameText, taskDescription: taskDescriptionText)
                self.tasks.append(task)
                RealmDataBaseManager.shared.create(task: task)
                
                
                self.tableView.reloadData()
            }
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

