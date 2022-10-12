//
//  TaskModel.swift
//  ToDoList
//
//  Created by Saidac Alexandru on 28.09.2022.
//

import Foundation
import RealmSwift


struct Task{
    let id:String
    var taskName:String
    var taskDescription:String
    var isCompleted = false
    let date:Date
    
    init(id: String, taskName: String, taskDescription: String, isCompleted: Bool = false, date: Date = Date()) {
        self.id = id
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.date = date 
    }
    
    mutating func toggleCompletion() {
        isCompleted = !isCompleted
    }
}

class TaskRealmModel: Object{
    @Persisted(primaryKey: true) var _id: String
    @Persisted var taskName:String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var isCompleted:Bool = false
    @Persisted var date: Date
    
}

