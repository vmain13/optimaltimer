//
//  ViewController.swift
//  OptimalTimer
//
//  Created by SOM Media Center on 12/8/17.
//  Copyright © 2017 Beatio LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    
    var seconds = 20
    var rest = 10
    
    var timer = Timer()
    var timer2 = Timer()
    var timerOn = false
    // has the pause button been tapped
    var resumeTapped = false
    
    
    //MARK: - IBactions
    @IBAction func startButtonTapped(_ sender: Any) {
        if timerOn == false {
            runTimer()
        }
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        timerOn = true
    }
    func restTimer(){
        timer2 = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(ViewController.updaterestTimer)), userInfo: nil, repeats: true)
        timerOn = true
    }
//work
    @objc func updateTimer() {
        rest = 10
        if seconds < 1 {
            timer.invalidate()
            restTimer()
        } else {
            seconds -= 1
            timerLabel.text = timeString(time:TimeInterval(seconds))
        }
    }
//Rest
    @objc func updaterestTimer() {
        seconds = 20
        if rest < 1 {
            timer2.invalidate()
            runTimer()
        } else {
            rest -= 1
            restLabel.text =
                timeString(time:TimeInterval(rest))
        }
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if self.resumeTapped == false {
            // stop timer without resetting the current value of seconds
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timer.invalidate()
        seconds = 20
        timerLabel.text = timeString(time:TimeInterval(seconds))
        timerOn = false
    }
    
    func timeString(time:TimeInterval) -> String{
        let minutes = Int(time)/60 % 60
        let seconds = Int(time)%60
        return String(format:"%02i:%02i",minutes, seconds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

