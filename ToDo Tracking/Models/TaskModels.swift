//
//  TaskModels.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 8/31/26.
//

// Generating the "Brain" of ourt project with the models for groups and tasks

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    var drawingData: Data?
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
}

// Mock Data / Fake Data to test our project

extension TaskGroup {
    static var sample: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [
            TaskItem(title: "Finish Assignment"),
            TaskItem(title: "Study for Test", isCompleted: true)
        ]),
        
        TaskGroup(title: "Home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Buy Groceries", isCompleted: true),
            TaskItem(title: "Walk the dogs")
        ])
    ]
}

extension Profile {
    static let sampleProfile: [Profile] = [
        Profile(name: "Professor", profileImage: "professor_img", groups: TaskGroup.sample),
        Profile(name: "Student", profileImage: "student_img", groups: []),
    ]
}

extension Array where Element == TaskItem {
    // Count the isCompleted total tasks
    var completedCount: Int {
        filter { $0.isCompleted }.count
    }
    
    // Percentage isComplete / Total Tasks
    var progress: Double {
        isEmpty ? 0 : Double(completedCount) / Double(count)
    }
    
}
