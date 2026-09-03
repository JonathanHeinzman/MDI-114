//
//  ContentView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 8/31/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var taskGroups = TaskGroup.sample
    @State private var selectedGroup: TaskGroup? // optional value
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // COLUMN 1: SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("To Do Tracking")
            .listStyle(.sidebar)
            .toolbar {
                Button{
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            // COLUMN 2
        } detail: {
            if let group = selectedGroup {
                // find the index of the selected group
                if let index = taskGroups.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
}

#Preview {
    ContentView()
}
