//
//  Todo.swift
//  todo-coursera
//
//  Created by preety on 26/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
}

struct Todo: Codable {
    let item: String
    let priority: Int
}
