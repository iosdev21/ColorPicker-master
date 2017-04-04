//
//  ViewController.swift
//  TestSwiftProject
//
//  Created by Born2invest on 28/05/16.
//  Copyright © 2016 TheAppSpace. All rights reserved.
//

import UIKit

class ViewController: UIViewController,colorDelegate {
    @IBOutlet var colorPicker: ColorPicker!
    @IBOutlet var colorView: UIView!
    @IBOutlet weak var canvasView: UIView!

    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 180
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self;
        
        runTimer();
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func pickedColor(_ color: UIColor) {
        colorView.backgroundColor = color;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timeLabel.text = timeString(time: TimeInterval(seconds))
        
        if (seconds == 0) {
            seconds = 180
        }
    }

    func resetTimer() {
        timer.invalidate()
        seconds = 180
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i : %02i", minutes, seconds)
    }
    
    
    
}

