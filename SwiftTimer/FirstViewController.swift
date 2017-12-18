//
//  FirstViewController.swift
//  SwiftTimer
//
//  Created by roger on 16/12/2017.
//  Copyright © 2017 Swift Data Technologies SL. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var hasPlayed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func startStopTimer2(_ sender: Any) {
        if(isPlaying) {
            // STOP
            timer.invalidate()
            isPlaying = false
            hasPlayed = true
            startStopButton.setTitle("RESET",for: .normal)
        } else {
            if(hasPlayed) {
                //RESET
                counter = 0.0
                UpdateTimer()
                hasPlayed = false
                startStopButton.setTitle("START",for: .normal)
            } else {
                // START
                timer = Timer.scheduledTimer(timeInterval: 0.07, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
                isPlaying = true
                startStopButton.setTitle("STOP",for: .normal)
            }
        }
        return
    }
    
    @objc
    func UpdateTimer() {
        let s: Double = counter.truncatingRemainder(dividingBy: 60)
        let m: Int = Int(counter) / 60
        
        timeLabel.text = String(format: "%02d:%05.2f", m, s)
        //timeLabel.text = String(format: "%2.2f", counter)
        counter = counter + 0.07
    }
}

