//
//  ContentView.swift
//  Gnome
//
//  Created by Connor Kale on 4/24/25.
//

import SwiftUI
import CoreMotion
//let motionManager = CMMotionManager() //CrapGPT gave me this


struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    var body: some View {
        
        let backgroundColor: Color
            if motionManager.accelerometerData.total < 1.5 {
                backgroundColor = Color(red: 0.0, green: 1.0, blue: 0.0) // Red
            } else if motionManager.accelerometerData.total >= 1.5 && motionManager.accelerometerData.total <= 3 {
                backgroundColor = Color(red: 1.0, green: 0.0, blue: 0.0) // Green
            } else {
                backgroundColor = Color(red: 0.0, green: 0.0, blue: 1.0) // Blue
            }

        return VStack {

            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")


            Text("Accelerometer Data")
                .font(.headline)
            Text("X: \(motionManager.accelerometerData.x, specifier: "%.2f")")
            Text("Y: \(motionManager.accelerometerData.y, specifier: "%.2f")")
            Text("Z: \(motionManager.accelerometerData.z, specifier: "%.2f")")
            Text("Total: \(motionManager.accelerometerData.total, specifier: "%.2f")")
                .padding()
        }
        .padding()
        .background(backgroundColor) // Set background color based on accelerometer data
        .ignoresSafeArea() // Optional: To fill the entire screen with color

        .onAppear {
            // Additional setup if needed
        }
        .onDisappear {
            // Any cleanup if needed
        }

    }
}

#Preview {
    ContentView()
}
