//
//  HabitModel.swift
//  Habit Tracking App
//
//  Created by Khaled on 11/01/2025.
//

struct HabitModel {
    var key: String
    var name: String
    var isCompleted: Bool
    var date: String
    
    // Initializer
    init(key: String, name: String, isCompleted: Bool, date: String) {
        self.key = key
        self.name = name
        self.isCompleted = isCompleted
        self.date = date
    }
}
