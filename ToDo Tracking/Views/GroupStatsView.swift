//
//  GroupStatsView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 9/2/26.
//

import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    
    // Count the isCompleted total tasks
    var completedCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    // Percentage isComplete / Total Tasks
    var progress: Double {
        tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)
    }
    
    var body: some View {
        HStack {
            // Progress Ring
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.green)
        
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.green)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 60, height: 60)
            .padding()
            
            // Text Info
            VStack(alignment: .leading) {
                Text("Task Progress")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("\(completedCount) / \(tasks.count) Completed")
                    .font(.title)
                    .bold()
            }
            Spacer() // push everything to the left
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
