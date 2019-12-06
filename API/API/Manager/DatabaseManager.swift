//
//  DatabaseManager.swift
//  API
//
//  Created by Yasin Akbaş on 6.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import Foundation

public class DatabaseManager<T:Identifiable> {
        
    public func getTodoList() -> [T] {
        return Todo.all() as! [T]
    }
    
    public init() { }
}
