//
//  ViewController.swift
//  clock
//
//  Created by user241078 on 6/10/23.
//

import UIKit

@objcMembers class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    @IBOutlet weak var cancelTimerButton: UIButton!
    
    var countdownTimer: Timer?
        var countdownSeconds = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            datePicker.minimumDate = Date()
            countdownLabel.text = "0 seconds"
            startClockTimer()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            stopCountdownTimer()
            stopClockTimer()
        }
        
        @IBAction func startButtonTapped(_ sender: UIButton) {
            countdownTimer?.invalidate()
            
            let selectedDate = datePicker.date
            let currentDate = Date()
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: selectedDate)
            
            if let hours = components.hour, let minutes = components.minute, let seconds = components.second {
                countdownSeconds = hours * 3600 + minutes * 60 + seconds
                
                if countdownSeconds > 0 {
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                    startButton.isEnabled = false
                    datePicker.isEnabled = false
                    cancelTimerButton.isEnabled = true
                    updateCountdownLabel()
                }
            }
        }
    
        @IBAction func cancelTimerButtonTapped(_ sender: UIButton) {
            print("canceled")
            stopCountdownTimer()
            countdownSeconds = 0
            countdownLabel.text = "0 seconds"
            startButton.isEnabled = true
            datePicker.isEnabled = true
            cancelTimerButton.isEnabled = false
        }
        
        @objc func updateTimer() {
            if countdownSeconds > 0 {
                countdownSeconds -= 1
                updateCountdownLabel()
            } else {
                stopCountdownTimer()
            }
        }
        
        func stopCountdownTimer() {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
        
        func updateCountdownLabel() {
            let hours = countdownSeconds / 3600
            let minutes = (countdownSeconds % 3600) / 60
            let seconds = countdownSeconds % 60
            
            countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        @IBOutlet weak var clockLabel: UILabel!
        
        var clockTimer: Timer?
        
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            stopClockTimer()
//        }
        
        func startClockTimer() {
            clockTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.updateClock()
            }
        }
        
        func stopClockTimer() {
            clockTimer?.invalidate()
            clockTimer = nil
        }
        
        func updateClock() {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, dd MMM yyyy hh:mm:ss a"
            let currentTime = dateFormatter.string(from: currentDate)
            
            let isAM = currentTime.contains("AM")
            
            DispatchQueue.main.async { [weak self] in
                self?.clockLabel.text = currentTime
                self?.view.backgroundColor = isAM ? UIColor.orange : UIColor.blue
            }
        }


//    var seconds = 0
//    var timer = Timer()
//    var isTimerRunning = false
//    var resumeTapped = false
//
//    @IBAction func startButton(_ sender: UIButton) {
//        if isTimerRunning == false {
//            let theTime = countdownTimer.countDownDuration
//            timeRemainingUI.text = timeString(time: TimeInterval(theTime))
//            runTimer()
//        }
//    }
//
//    @IBAction func pauseButton(_ sender: UIButton) {
//        if self.resumeTapped == false {
//            timer.invalidate()
//            self.resumeTapped = true
//        } else {
//            runTimer()
//            self.resumeTapped = false
//        }
//    }
//
//        @IBAction func runTimer() {
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
//
//            isTimerRunning = true
//
//        }
//
//    @IBAction func resetButton(_ sender: UIButton) {
//        timer.invalidate()
//        var seconds = countdownTimer.countDownDuration
//        timeRemainingUI.text = timeString(time: TimeInterval(seconds))
//        isTimerRunning = false
//    }
//
//
//        func updateTimer() {
//            if theTime < 1 {
//                timer.invalidate()
//            } else {
//                theTime -= 1
//                timeRemainingUI.text = timeString(time: TimeInterval(theTime))
//            }
//        }
//
//        func timeString(time:TimeInterval) -> String {
//            let hours = Int(time) / 3600
//            let minutes = Int(time) / 60 % 60
//            let seconds = Int(time) % 60
//            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //var timer = Timer()
    
    //let date = Date()
    
    //let dateFormatter = DateFormatter()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
//        }
//
//
//
//        @objc func tick() {
//            dateFormatter.dateFormat = "EEEE, dd MMM YYYY hh:mm:ss"
//            let result = dateFormatter.string(from: date)
//            labelDate.text = result
//        }
//




