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
    
    
    mutating func toggleCompletion() {
        isCompleted = !isCompleted
    }
}

class TaskRealmModel: Object{
    @Persisted(primaryKey: true) var _id: String
    @Persisted var taskName:String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var isCompleted:Bool = false
    
}

