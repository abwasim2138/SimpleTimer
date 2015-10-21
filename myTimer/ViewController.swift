//
//  ViewController.swift
//  myTimer
//
//  Created by Abdul-Wasai Wasim on 10/21/15.
//  Copyright © 2015 Laylapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    //MARK: - IBOutlets
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var secondsPickerView: UIPickerView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
 
    
    //MARK: Properties
    var timer = NSTimer()
    var totalSeconds = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allowance = UIUserNotificationSettings(forTypes: [.Alert,.Badge,.Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(allowance)
    }
    
    
    // MARK: - UIPickerView Setup
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard pickerView == secondsPickerView else {
            return 1
        }
        return 61
    }
    

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let myLabel = UILabel()
        myLabel.backgroundColor = UIColor.whiteColor()
        myLabel.text = "\(Array(0...60)[row])"
        return myLabel
        
    }
    
    
    //MARK: - FUNCTIONS FOR TIMER
    
    @IBAction func startButton(sender: UIButton) {
        if startButton.currentTitle == "START" {
        totalSeconds = secondsPickerView.selectedRowInComponent(0)
        startTimer()
        startButton.setTitle("Cancel", forState: .Normal)
        }else {
            timer.invalidate()
            timerLabel.text = "00:00"
              startButton.setTitle("START", forState: .Normal)
            
        }
    }
    
    @IBAction func pauseButton(sender: UIButton) {
        if pauseButton.currentTitle == "PAUSE" {
            timer.invalidate()
            pauseButton.setTitle("Resume", forState: .Normal)
        }else{
            startTimer()
        }
        
    }
    
    func startTimer () {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countdown", userInfo: nil, repeats: true)
    }
    
    func countdown () {
     
        totalSeconds--
        var valueOfTimer = "00:"
        
        if totalSeconds < 10 {
            valueOfTimer = "00:0"
        }
        timerLabel.text = "\(valueOfTimer)\(totalSeconds)"
        
        if totalSeconds < 0 {
            
            timer.invalidate()
            pushAlert()
            popAlert()
            return timerLabel.text = "OVER"
            
        }
    }
    
    
    func pushAlert () {
        let notification = UILocalNotification()
        notification.alertTitle = "Timer"
        notification.alertBody = "Timers up homie"
        notification.alertAction = "OKAY G"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
    }
    
    func popAlert () {
        let alertController = UIAlertController(title: "TIMES UP", message: "", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OKAY", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
}

