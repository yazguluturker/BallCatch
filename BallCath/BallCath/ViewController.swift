//
//  ViewController.swift
//  BallCath
//
//  Created by Yazgülü Türker on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var ball1: UIImageView!
    @IBOutlet weak var ball2: UIImageView!
    @IBOutlet weak var ball3: UIImageView!
    @IBOutlet weak var ball4: UIImageView!
    @IBOutlet weak var ball5: UIImageView!
    @IBOutlet weak var ball6: UIImageView!
    @IBOutlet weak var ball7: UIImageView!
    @IBOutlet weak var ball8: UIImageView!
    @IBOutlet weak var ball9: UIImageView!
    
    var score = 0
    var time = Timer()
    var count = 0
    var ballArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil
        {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int
        {
            highScore = newScore
            highScoreLabel.text = "Highscore :\(highScore)"
        }
   
     
        //We have enabled touch
        ball1.isUserInteractionEnabled = true
        ball2.isUserInteractionEnabled = true
        ball3.isUserInteractionEnabled = true
        ball4.isUserInteractionEnabled = true
        ball5.isUserInteractionEnabled = true
        ball6.isUserInteractionEnabled = true
        ball7.isUserInteractionEnabled = true
        ball8.isUserInteractionEnabled = true
        ball9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        //We added gesture recognizer photos(ball)
        ball1.addGestureRecognizer(recognizer1)
        ball2.addGestureRecognizer(recognizer2)
        ball3.addGestureRecognizer(recognizer3)
        ball4.addGestureRecognizer(recognizer4)
        ball5.addGestureRecognizer(recognizer5)
        ball6.addGestureRecognizer(recognizer6)
        ball7.addGestureRecognizer(recognizer7)
        ball8.addGestureRecognizer(recognizer8)
        ball9.addGestureRecognizer(recognizer9)
        
        ballArray = [ball1,ball2,ball3,ball4,ball5,ball6,ball7,ball8,ball9]
        
        //Timers
        
        count = 10
        timeLabel.text = String(count)
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideBall), userInfo: nil, repeats: true)
    
        
        }
    
   @objc func hideBall()
    {
        for ball in ballArray
        {
            ball.isHidden = true
        }
        
        //random number
        let random = Int(arc4random_uniform(UInt32(ballArray.count-1)))
        //random ball is hide
        ballArray[random].isHidden = false

    }
    
    @objc func countDown()
    {
        
        count -= 1
        timeLabel.text = String(count)
  
        if count == 0
        {
            //Stop Time
            time.invalidate()
            hideTimer.invalidate()
            
             //HighScore
            
            if score>highScore
            {
                self.highScore = self.score
                highScoreLabel.text = "HighScore:\(self.highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
                 
            }
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style:
                    .default)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default)
            {
                (UIAlertAction) in
                //Replay function
                
                self.score = 0
                self.scoreLabel.text = "Score\(self.score)"
                self.count = 10
                self.timeLabel.text = String(self.count)
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideBall), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
         }
        
    
    
        
        
       
    }
    
    @objc func increaseScore ()
    {
        score += 1
        scoreLabel.text =  "Score: \(score)"
        
        
        
     
        
    }
    
    


}

