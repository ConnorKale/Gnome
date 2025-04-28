//
//  MotionManager.swift
//  Gnome
//
//  Created by Connor Kale on 4/24/25.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private let updateInterval = 0.1
    
    @Published var accelerometerData: (x: Double, y: Double, z: Double, total: Double) = (0, 0, 0, 0)
    
    init() {
        startAccelerometerUpdates()
    }
    
    private func startAccelerometerUpdates() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer is not available.")
            return
        }

        motionManager.accelerometerUpdateInterval = updateInterval
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let data = data else {
                if let error = error {
                    print("Accelerometer error: \(error.localizedDescription)")
                }
                return
            }

            let x = data.acceleration.x
            let y = data.acceleration.y
            let z = data.acceleration.z
            let total = sqrt(x * x + y * y + z * z)
            self?.accelerometerData = (x, y, z, total)
        }
    }
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}
/*
 let x = accelerometerData.acceleration.x
 let y = accelerometerData.acceleration.y
 let z = accelerometerData.acceleration.z
 
 let total = sqrt(x * x + y * y + z * z)
 self?.accelerometerData = (x, y, z, total)

*/
