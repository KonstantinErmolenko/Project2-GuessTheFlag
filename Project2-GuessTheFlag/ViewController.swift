//
//  ViewController.swift
//  Project2-GuessTheFlag
//
//  Created by Ермоленко Константин on 15.03.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    // MARK: - Private Properties
    private var countries = [String]()
    private var score = 0
    private var correctAnswer = 0
    private var questionsAnswered = 0
    private var gameOver = false
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCountries()
        customizeAppearance()
        setupNavigationBar()
        askQuestion()
    }
    
    // MARK: - IB Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if gameOver { return }
        
        questionsAnswered += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            let chosenFlag = countries[sender.tag].uppercased()
            title = "Wrong! That’s the flag of \(chosenFlag)"
            score -= 1
        }
        
        let alert = UIAlertController(title: title,
                                   message: "Your score is \(score)",
                                   preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: nextAction))
        present(alert, animated: true)
    }
    
    // MARK: - Private Methods
    private func initializeCountries() {
        countries += ["estonia", "france", "germany",
                     "ireland", "italy", "monaco",
                     "nigeria", "poland", "russia",
                     "spain", "uk", "us"]
    }
    
    private func customizeAppearance() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setTitle() {
        title = "\(countries[correctAnswer].uppercased())"
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Score",
            style: .plain,
            target: self,
            action: #selector(showScore)
        )
    }
    
    private func nextAction(action: UIAlertAction! = nil) {
        if questionsAnswered >= 5 {
            showResult()
        } else {
            askQuestion(action)
        }
    }
    
    private func askQuestion(_ action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        setTitle()
    }
    
    private func showResult() {
        gameOver = true

        setTitle()
        
        let alert = UIAlertController(title: "Game is over",
                                      message: "Your score is \(score)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc  private func showScore() {
        let ac = UIAlertController(
            title: "Total score",
            message: "Your score is \(score)",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

