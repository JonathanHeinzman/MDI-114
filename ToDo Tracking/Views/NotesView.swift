//
//  NotesView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 9/10/26.
//

import SwiftUI
import PencilKit

struct NotesView: View {
    
    @Binding var group: TaskGroup
    @State private var canvasView = PKCanvasView()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        DrawingView(
            drawingData: $group.drawingData,
            canvasView: $canvasView
        )
        .navigationTitle("\(group.title) Notes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Tasks", systemImage: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    canvasView.drawing = PKDrawing()
                    group.drawingData = nil
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
