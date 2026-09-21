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
    @Environment(\.colorScheme) var colorScheme
    
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
                        .accessibilityIdentifier("task_title_field")
                }
                .accessibilityIdentifier("task_completed_toggle")
            }
            .onDelete { index in
                group.tasks.remove(atOffsets: index)
            }
            .accessibilityIdentifier("delete_task")
        }
        .navigationTitle(group.title)
        .toolbar {
            
            HStack(spacing: 12) {
                
                NavigationLink {
                    NotesView(group: $group)
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "pencil.line")
                        Text("Notes")
                    }
                }
                
                Divider()
                    .frame(height: 18)
                    .overlay(colorScheme == .dark ? Color.white : Color.gray)
                
                Button("Add Task") {
                    withAnimation {
                        group.tasks.append(TaskItem(title: ""))
                    }
                }
                .accessibilityIdentifier("add_new_task")
            }
        }
    }
}
