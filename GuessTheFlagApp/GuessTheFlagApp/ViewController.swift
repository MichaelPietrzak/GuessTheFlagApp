//
//  ViewController.swift
//  GuessTheFlagApp
//
//  Created by Michal Pietrzak on 14/10/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "YOUR SCORE", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showScoreTapped))
    }
    
    @objc func showScoreTapped() {
        let scoreTap = UIAlertController(title: "Your score", message: "\(score) points", preferredStyle: .alert)
        scoreTap.addAction(UIAlertAction(title: "OK", style: .default, handler: .none))
        present(scoreTap, animated: true)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        print("\(countries[0].uppercased()), \(countries[1].uppercased()), \(countries[2].uppercased())")
        
        correctAnswer = Int.random(in: 0...2)
        print("\(correctAnswer) : \(countries[correctAnswer].uppercased())")
        
        title = "\(countries[correctAnswer].uppercased()), Score: \(score)"
    }
    
    
    // Start a new game
    func restartGame(action: UIAlertAction! = nil) {
        score = 0
        questionsAsked = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        questionsAsked += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            print("Correct!")
        } else {
            title = "Wrong! That's flag of \(countries[sender.tag].uppercased())"
            score -= 1
            print("Wrong!")
        }
        
        if questionsAsked == 10 {
            let finalAlertController = UIAlertController(title: "Game over!", message: "Your score is \(score).", preferredStyle: .alert)
            finalAlertController.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: restartGame))
               present(finalAlertController, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
}

