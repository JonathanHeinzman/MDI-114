//
//  NewGroupView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 9/2/26.
//

import SwiftUI

struct NewGroupView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    var onSave: (TaskGroup) -> Void
    let icons = ["list.bullet", "heart.fill", "book.fill", "person.fill", "house.fill", "star.fill", "cart.fill", "figure.fishing", ]
    
    var body: some View {
        NavigationStack {
            Form {
                // SECTION 1 : NAME OF THE GROUP
                Section("Group Name"){
                    TextField("e.g. Work, School, Personal", text: $groupName)
                        .accessibilityIdentifier("group_name_field")
                }
                
                // SECTION 2 : ICON
                Section("Select Icon"){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]){
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(selectedIcon == icon ? Color.blue.opacity(0.3) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.purple : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
                
            }
            .navigationTitle("New Group")
            .toolbar {
                // item 1 : Left = Cancel
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("cancel_button")
                }
                    
                // item 2 : Right = Save
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                    .accessibilityIdentifier("save_button")
                    .disabled(groupName.isEmpty) // disable save button if group name is empty
                }
            }
        }
    }
}
