//
//  TaskGroupDetailView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 8/31/26.
//

import SwiftUI

struct TaskGroupDetailView: View {
    
    @Binding var group: TaskGroup
    
    var body: some View {
        List {
            ForEach($group.tasks) { $task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .green : .gray)
                        .onTapGesture {
                            withAnimation {
                                task.isCompleted.toggle()
                            }
                        }
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                }
            }
            .onDelete { index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation {
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}
