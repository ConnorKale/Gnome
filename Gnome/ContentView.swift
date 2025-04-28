//
//  ContentView.swift
//  Gnome
//
//  Created by Connor Kale on 4/24/25.
//

import SwiftUI
//import CoreMotion


struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    
    @State private var tone: TonePlayer? = nil
    @State private var tonePitch: Float = 440.0

    private var backgroundColor: Color {
        switch motionManager.accelerometerData.total {
        case ..<1.5:
            return Color(red: 0.0, green: 1.0, blue: 0.0) // Green
        case 1.5...3:
            return Color(red: 1.0, green: 0.0, blue: 0.0) // Red
        default:
            return Color(red: 0.0, green: 0.0, blue: 1.0) // Blue
        }
    }
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .padding(.bottom, 30)
            
            Text("Accelerometer Data:")
                .font(.headline)
            Text("X: \(motionManager.accelerometerData.x, specifier: "%.2f")")
            Text("Y: \(motionManager.accelerometerData.y, specifier: "%.2f")")
            Text("Z: \(motionManager.accelerometerData.z, specifier: "%.2f")")
                .padding(.bottom, 30)
            Text("Pitch: \(tonePitch, specifier: "%.2f")")
                .font(.headline)
                .padding(.bottom, 50)
            
            Text("Total:")
                .font(.system(size: 50))
            Text("\(motionManager.accelerometerData.total, specifier: "%.2f")")
            //.padding()
                .font(.system(size: 150))
        }
        .padding()
        .background(backgroundColor) // Set background color based on accelerometer data
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if tone == nil {
                tone = TonePlayer(frequency: tonePitch)
            }
        }
        .onChange(of: motionManager.accelerometerData.total) { newTotal in
            // Update the pitch based on accelerometer data (total magnitude)
            tonePitch = Float(440 * newTotal)
        }
        .onChange(of: tonePitch) { newPitch in
            // Update the frequency of the tone when the pitch changes
            tone?.updateFrequency(to: newPitch)
        }
    }
}


#Preview {
    ContentView()
}
