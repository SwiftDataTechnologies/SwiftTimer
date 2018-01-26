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

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var accelX: UILabel!
    @IBOutlet weak var accelY: UILabel!
    @IBOutlet weak var accelZ: UILabel!
    @IBOutlet weak var speedGPS: UILabel!
    @IBOutlet weak var latGPS: UILabel!
    @IBOutlet weak var lonGPS: UILabel!
    @IBOutlet weak var gpsStatus: UILabel!
    
    var motionManager: CMMotionManager!
    var locationManager: CLLocationManager!
    var maxXAccel = 0.0
    var maxYAccel = 0.0
    var maxZAccel = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Accelerometer data */
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.001
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
            self.accelX.text = "Max turning: "      + String(format: "%04.2f", self.maxXAccel) + " g"
            self.accelY.text = "Max vertical: "     + String(format: "%04.2f", self.maxYAccel) + " g"
        })
        
        /* GPS data */
        locationManager = CLLocationManager()
        // TODO: request at launch time since location is key!!!!
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the location service.
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        //let lastTime  = manager.location!.timestamp
        let lastCoord = manager.location!.coordinate
        let lastSpeed = manager.location!.speed
        //let lastCourse = manager.location!.course
        let horAccur  = manager.location!.horizontalAccuracy
        self.speedGPS.text =  "GPS Speed: "     + String(format: "%.1f", 3.6*lastSpeed)  + " km/h"
        self.latGPS.text =    "GPS Lat: "       + String(format: "%.5f", lastCoord.latitude)
        self.lonGPS.text =    "GPS Long: "      + String(format: "%.5f", lastCoord.longitude)
        self.gpsStatus.text = "GPS Accuracy: "  + String(format: "%.0f", horAccur) + " m"
    }
    
    
    /*func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        // Display error in GPS status info text
        self.gpsStatus.text = "Error \(error)"
    }*/

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

