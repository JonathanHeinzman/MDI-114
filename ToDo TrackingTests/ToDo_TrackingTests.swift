//
//  ToDo_TrackingTests.swift
//  ToDo TrackingTests
//
//  Created by Jonathan Heinzman on 8/31/26.
//

import Testing
@testable import ToDo_Tracking

struct ToDo_TrackingTests {

    @Test func progressIsZeroWhenThereAreNoTasks() {
        
        let tasks: [TaskItem] = []
        
        #expect(tasks.progress == 0)
        #expect(tasks.completedCount == 0)
        
    }
    
    @Test func progressReflectsCompletedTasks() {
        
        let tasks = [
            TaskItem(title: "Finish Assignment", isCompleted: false),
            TaskItem(title: "Study for Test", isCompleted: true)
            
        ]
        
        #expect(tasks.completedCount == 1)
        #expect(tasks.progress == 0.5)
    }
}
