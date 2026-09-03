//
//  TaskGroupDetailView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 8/31/26.
//

import SwiftUI

struct TaskGroupDetailView: View {
    
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        List {
            Section{
                if sizeClass == .regular {
                    GroupStatsView(tasks: group.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
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
