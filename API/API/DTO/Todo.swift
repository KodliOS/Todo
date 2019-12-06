//
//  Todo.swift
//  API
//
//  Created by Yasin Akbaş on 6.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import Foundation

public protocol Identifiable {
    var id:Int { get set }
}

public class Todo: Identifiable {
    public var id: Int
    public let title: String
    public let description: String
    
    public init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    public static func all() -> [Todo] {
        return [
            Todo(id: 0, title: "Oguz Ozturk", description: "...."),
            Todo(id: 1, title: "Berk Batuhan Sakar", description: "...."),
            Todo(id: 2, title: "Husamettin Eyibil", description: "...."),
            Todo(id: 3, title: "Onuc Ciicek", description: "...."),
            Todo(id: 4, title: "Yasin Akbas", description: "....")
        ]
    }
}
