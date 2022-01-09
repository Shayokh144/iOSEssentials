//
//  Task.swift
//  RxToDoList
//
//  Created by Asif on 8/1/22.
//

import Foundation
enum Priority : Int{
    case high = 0
    case medium
    case low
}

struct Task{
    let title : String
    let priority : Priority
}
