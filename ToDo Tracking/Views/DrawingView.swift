//
//  DrawingView.swift
//  ToDo Tracking
//
//  Created by Jonathan Heinzman on 9/10/26.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    
    @Binding var drawingData: Data?
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        
        // Load saved drawing
        if let drawingData = drawingData,
           let savedDrawing = try? PKDrawing(data: drawingData) {
            canvasView.drawing = savedDrawing
        }
        
        // Show PencilKit tools
        context.coordinator.toolPicker.setVisible(
            true,
            forFirstResponder: canvasView
        )
        
        context.coordinator.toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    static func dismantleUIView(
        _ uiView: PKCanvasView,
        coordinator: Coordinator
    ) {
        coordinator.toolPicker.setVisible(
            false,
            forFirstResponder: uiView
        )
        
        coordinator.toolPicker.removeObserver(uiView)
        uiView.resignFirstResponder()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        
        var parent: DrawingView
        let toolPicker = PKToolPicker()
        
        init(_ parent: DrawingView) {
            self.parent = parent
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawingData = canvasView.drawing.dataRepresentation()
        }
    }
}
