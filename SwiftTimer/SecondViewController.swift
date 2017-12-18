//
//  SecondViewController.swift
//  SwiftTimer
//
//  Created by roger on 16/12/2017.
//  Copyright © 2017 Swift Data Technologies SL. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class SecondViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var accelX: UILabel!
    @IBOutlet weak var accelY: UILabel!
    @IBOutlet weak var accelZ: UILabel!
    @IBOutlet weak var speedGPS: UILabel!
    
    var motionManager: CMMotionManager!
    var locationManager: CLLocationManager!
    var maxXAccel = 0.0
    var maxYAccel = 0.0
    var maxZAccel = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Accelerometer data
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { data, error in
            guard error == nil else { return }
            guard let accelerometerData = data else { return }
            let currentAccelX = accelerometerData.acceleration.x
            let currentAccelY = accelerometerData.acceleration.y
            let currentAccelZ = accelerometerData.acceleration.z
            if(abs(currentAccelX) > self.maxXAccel) {
                self.maxXAccel = abs(currentAccelX)
            }
            if(abs(currentAccelY) > self.maxYAccel) {
                self.maxYAccel = abs(currentAccelY)
            }
            if(abs(currentAccelZ) > self.maxZAccel) {
                self.maxZAccel = abs(currentAccelZ)
            }
            self.accelZ.text = "Max acceleration: " + String(format: "%04.2f", self.maxZAccel) + " g"
            self.accelX.text = "Max turning: " + String(format: "%04.2f", self.maxXAccel) + " g"
            self.accelY.text = "Max vertical: " + String(format: "%04.2f", self.maxYAccel) + " g"
        })
        
        // GPS data
        locationManager = CLLocationManager()
        let speed = locationManager.location!.speed
        self.speedGPS.text = String(format: "%04.2f", speed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

