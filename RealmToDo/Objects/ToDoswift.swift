//
//  ToDoswift.swift
//  RealmToDo
//
//  Created by 高橋達朗 on 2019/07/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import RealmSwift

class Todo: Object {
    
    @objc dynamic var id: Int = 0
    
    @objc dynamic var title: String = ""
    
    @objc dynamic var date: Date = Date()
    
}
