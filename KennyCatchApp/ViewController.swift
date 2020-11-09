//
//  ViewController.swift
//  KennyCatchApp
//
//  Created by Dogukan Yolcuoglu on 9.11.2020.
//  Copyright © 2020 Dogukan Yolcuoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    
    //MARK: - Variables
    var timer = Timer();
    var hiddenTimer = Timer();
    var counter = 0;
    var score = 0;
    var topScore = 0;
    var kennyArray = [UIImageView]();
    var player:String?
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentlyScore: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    
    //MARK: - Statement Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let high = UserDefaults.standard.object(forKey: "High")
        
        if high == nil {
            topScore = 0;
            highScore.text = "High Score: \(topScore)"
        }
        if let newScore = high as? Int {
            
            topScore = newScore;
            highScore.text = "High Score: \(topScore)"
        }
        
        
        counter = 30;
        timerLabel.text = String(counter);
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Update), userInfo: nil, repeats: true)
        hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(kennyHidden), userInfo: nil, repeats: true)
        
        kennyArray = [imageView,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9];
        
        imageViewFeature();
        
    }
    
    //MARK: - Functions
    
    //Time countDown
    @objc func Update(){
        
        counter -= 1;
        timerLabel.text = String(counter);
        kennyHidden();
        if counter == 0 {
            timerLabel.text = String(counter);
            timer.invalidate();
            hiddenTimer.invalidate();
            
            var i = 0;
            while i < 9 {
                
                kennyArray[i].isHidden = true;
                
                i += 1;
            }
            
            resultScore();
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want play again ?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            
            let replay = UIAlertAction(title: "Replay" , style: .default) { (action) in
                
                self.playAgain();
            }
            
            
            alert.addAction(ok)
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //The Kenny hide and random show
    @objc func kennyHidden (){
        
        var i = 0;
        while i < 9 {
            
            kennyArray[i].isHidden = true;
            
            i += 1;
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false;
        
    }
    
    //When click imageview
    @objc func onImageViewTap()
    {
        score += 1;
        currentlyScore.text = "Score: \(score)";
    }
    
    
    func playAgain(){
        
        self.score = 0;
        self.counter = 30;
        self.currentlyScore.text = "Score: \(self.score)";
        self.timerLabel.text = String(self.counter)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.Update), userInfo: nil, repeats: true)
        self.hiddenTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.kennyHidden), userInfo: nil, repeats: true)
        
        
    }
    
    //Show high score
    func resultScore(){
        
        if topScore < score {
            
            topScore = score;
            highScore.text = "High Score: \(topScore)"
            UserDefaults.standard.set(topScore, forKey: "High")
        }
    }
    
    //Image clickable
    func imageViewFeature(){
        
        imageView.isUserInteractionEnabled = true;
        imageView2.isUserInteractionEnabled = true;
        imageView3.isUserInteractionEnabled = true;
        imageView4.isUserInteractionEnabled = true;
        imageView5.isUserInteractionEnabled = true;
        imageView6.isUserInteractionEnabled = true;
        imageView7.isUserInteractionEnabled = true;
        imageView8.isUserInteractionEnabled = true;
        imageView9.isUserInteractionEnabled = true;
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(onImageViewTap))
        
        
        imageView.addGestureRecognizer(recognizer1)
        imageView2.addGestureRecognizer(recognizer2)
        imageView3.addGestureRecognizer(recognizer3)
        imageView4.addGestureRecognizer(recognizer4)
        imageView5.addGestureRecognizer(recognizer5)
        imageView6.addGestureRecognizer(recognizer6)
        imageView7.addGestureRecognizer(recognizer7)
        imageView8.addGestureRecognizer(recognizer8)
        imageView9.addGestureRecognizer(recognizer9)
        
    }
    
}

