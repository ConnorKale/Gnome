//
//  MotionManager.swift
//  Gnome
//
//  Created by Connor Kale on 4/24/25.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    
    @Published var accelerometerData: (x: Double, y: Double, z: Double, total: Double) = (0, 0, 0, 0)
    
    init() {
        startAccelerometerUpdates()
    }
    
    private func startAccelerometerUpdates() {
          if motionManager.isAccelerometerAvailable {
              motionManager.accelerometerUpdateInterval = 0.1
              motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [weak self] (data, error) in
                  if let accelerometerData = data {
                      let x = accelerometerData.acceleration.x
                      let y = accelerometerData.acceleration.y
                      let z = accelerometerData.acceleration.z
                      
                      let total = sqrt(x * x + y * y + z * z)
                      
                      // Update the published accelerometerData property
                      self?.accelerometerData = (x, y, z, total)
                  } else if let error = error {
                      print("Error: \(error.localizedDescription)")
                  }
              }
          }
      }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}

/*
#Preview {
    MotionManager_()
}
*/
