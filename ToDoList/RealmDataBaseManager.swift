//
//  RealmDataBaseManager.swift
//  ToDoList
//
//  Created by Saidac Alexandru on 10.10.2022.
//

import Foundation
import RealmSwift

class RealmDataBaseManager{
    
    static let shared = RealmDataBaseManager()
    
    
    private init(){
        
    }
    
    func create(task: Task){
        do {
            let realm = try Realm()
            let taskRealm = TaskRealmModel(value: ["_id": task.id, "taskName" : task.taskName, "taskDescription" : task.taskDescription, "isCompleted": task.isCompleted])
            try realm.write{
                realm.add(taskRealm)
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    
    func read() -> [Task]{
        do{
            var tasks:[Task] = []
            let realm = try Realm()
            let tasksFromRealm = realm.objects(TaskRealmModel.self)
            for taskInRealm in tasksFromRealm{
                let task = Task(id: taskInRealm._id,   taskName: taskInRealm.taskName, taskDescription: taskInRealm.taskDescription, isCompleted: taskInRealm.isCompleted)
                tasks.append(task)
            }
            return tasks
        }catch let error as NSError{
            print(error.localizedDescription)
            return []
        }
    }
    
    func update(id: String, name:String, description:String , isComplete:Bool){
        do{
            let realm = try Realm()
            guard let task = realm.object(ofType: TaskRealmModel.self, forPrimaryKey: id)
            else {
                return
            }
            try realm.write {
                task.taskName = name
                task.taskDescription = description
                task.isCompleted = isComplete
            }

        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func delete(id: String){
        do{
            let realm = try Realm()
            guard let task = realm.object(ofType: TaskRealmModel.self, forPrimaryKey: id)
            else{
                return
            }
            try realm.write {
                realm.delete(task)
            }


        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
}
