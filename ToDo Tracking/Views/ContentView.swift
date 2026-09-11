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
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    
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
            Divider()
                .overlay( isDarkMode ? .white : .gray)
                .padding(.bottom, 20)
            Button{
                isDarkMode.toggle()
            } label: {
                Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                isDarkMode ? Text("Light Mode") : Text("Dark Mode")
            }
            .foregroundStyle(.primary)
            .padding(.bottom, 20)
            
            
            // COLUMN 2
        }
        
        detail: {
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
        .onAppear{
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("My App is ACTIVE")
            } else if newValue == .inactive {
                print("Oops user is looking ar something else")
            } else if newValue == .background {
                saveData()
                print("My app is saving data")
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    func saveData() {
        // Step 1: Convert Array -> JSON Data
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            // Step 2: Save the data into UserDefaults
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        // Step 1: Check if we have any data saved in UserDefaults
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            // Step 2: Try to Decode JSON -> Array for my view
            if let decodedData = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedData
                return
            }
        }
        // If no data is found, show the sample/mock data
        taskGroups = TaskGroup.sample
    }
}

#Preview {
    ContentView()
}
