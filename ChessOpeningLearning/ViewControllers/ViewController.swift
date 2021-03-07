//
//  ViewController.swift
//  ChessOpeningLearning
//
//  Created by Pablo Murnikovas on 4/3/21.
//  Copyright © 2021 Pablo Murnikovas. All rights reserved.
//

import UIKit

private enum FileConstants {
    static let rotationDivider: CGFloat = 2
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var playerOneView: UIView!
    @IBOutlet private weak var playerTwoView: UIView!
    @IBOutlet private weak var playerOneLabel: UILabel!
    @IBOutlet private weak var playerTwoLabel: UILabel!
    @IBOutlet private weak var openingLabel: UILabel!

    var openingToLearn: String = ""
    var openingToLearnName: String = ""
    var openings: [String:String] = [:]
    var openingComponents: [String.SubSequence] = []
    var openingMoves = 0
    var turnCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        loadMockOpenings()
        setupRandomOpening()
        setupViews()
        setupTexts()
    }
    
    func loadMockOpenings() {
        openings["Italian_Game"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4"
        openings["Ruy_Lopez"] = "1.e4 e5 2.Cf3 Cc6 3.Ab5"
        openings["Queen's_Gambit"] = "1.d4 d5 2.c4"
        openings["Hungarian Defense"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Be7"
        openings["Two_Knights_Defense"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Nf6"
    }
    
    func setupRandomOpening() {
        let randomOpening = openings.randomElement()
        turnCounter = 0
        if let name = randomOpening?.key, let openingInfo = randomOpening?.value {
            self.openingToLearnName = name
            self.openingToLearn = openingInfo
            self.openingComponents = openingToLearn.split(separator: " ")
            self.openingMoves = openingComponents.count
            self.openingLabel.text = openingToLearnName
        }
    }
    
    func setupTexts() {
        playerOneLabel.text = "Tap!"
        playerTwoLabel.text = ""
    }
    
    func setupViews() {
        rotateLabels()
        let gestureOne = UITapGestureRecognizer(target: self, action:  #selector(self.playerOneAction(sender:)))
        let gestureTwo = UITapGestureRecognizer(target: self, action:  #selector(self.playerTwoAction(sender:)))
        self.playerOneView.addGestureRecognizer(gestureOne)
        self.playerTwoView.addGestureRecognizer(gestureTwo)
    }
    
    @objc func playerOneAction(sender : UITapGestureRecognizer) {
        
        if (turnCounter ==  openingMoves) {
            
            openingLabel.text = "Tap for new Opening"
            //setupRandomOpening()
        }
        else if turnCounter % 1 == 0 {
            
            playerOneLabel.text = String(self.openingComponents[turnCounter])
            turnCounter = turnCounter + 1
            playerTwoLabel.text = "Tap!"
        }
    }
    
    @objc func playerTwoAction(sender : UITapGestureRecognizer) {
        
        if (turnCounter ==  openingMoves) {
            
            openingLabel.text = "Tap for new Opening"
            //setupRandomOpening()
        }
        else if turnCounter  % 2 == 0 {
            
            playerTwoLabel.text = String(self.openingComponents[turnCounter])
            turnCounter = turnCounter + 1
            playerOneLabel.text = "Tap!"
        }
    }
    
    func rotateLabels() {
        playerOneLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
        playerTwoLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
        openingLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
    }
}

