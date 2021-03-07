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
    static let turnDivider: Int = 2
    static let playerOneTurnDivider: Int = 0
    static let playerTwoTurnDivider: Int = 1
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var playerOneView: UIView!
    @IBOutlet private weak var playerTwoView: UIView!
    @IBOutlet private weak var playerOneLabel: UILabel!
    @IBOutlet private weak var playerTwoLabel: UILabel!
    @IBOutlet private weak var openingView: UIView!
    @IBOutlet private weak var openingLabel: UILabel!
    
    var openingToLearn: String = String.Empty
    var openingToLearnName: String = String.Empty
    var openings: [String:String] = [:]
    var openingComponents: [String.SubSequence] = []
    var openingMoves = 0
    var turnCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        loadMockOpenings()
        setupRandomOpening()
        setupViews()
        setupTexts()
        setupTextsFonts()
    }
    
    func loadMockOpenings() {
        openings["Italian Game"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4"
        openings["Ruy Lopez"] = "1.e4 e5 2.Cf3 Cc6 3.Ab5"
        openings["Queen's Gambit"] = "1.d4 d5 2.c4"
        openings["Hungarian Defense"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Be7"
        openings["Two Knights Defense"] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Nf6"
        openings["Sicilian - Dragon"] = " 1.e4 c5  2.Nf3 d6  3.d4 cxd4 4.Nxd4 Nf6  5.Nc3 g6"
    }
    
    func setupRandomOpening() {
        turnCounter = 0
        let randomOpening = openings.randomElement()
        if let name = randomOpening?.key, let openingInfo = randomOpening?.value {
            self.openingToLearnName = name
            self.openingToLearn = openingInfo
            self.openingComponents = openingToLearn.split(separator: Character.Space)
            self.openingMoves = openingComponents.count
            self.openingLabel.text = openingToLearnName
            self.openingView.isUserInteractionEnabled = false
            self.setupTexts()
        }
    }
    
    func setupViews() {
        rotateLabels()
        setupViewsActions()
    }
    
    func setupTexts() {
        playerOneLabel.text = NSLocalizedString("Opening_Tap", comment: String.Empty)
        playerTwoLabel.text = String.Empty
    }
    
    func setupTextsFonts() {
        playerOneLabel.font = UIFont.sfBoldFontOfSize32
        playerTwoLabel.font = UIFont.sfBoldFontOfSize32
        openingLabel.font = UIFont.sfRegularFontOfSize18
    }
    
    func rotateLabels() {
        playerOneLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
        playerTwoLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
        openingLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / FileConstants.rotationDivider)
    }
    
    func setupViewsActions() {
        let gesturePlayerOne = UITapGestureRecognizer(target: self, action:  #selector(self.playerOneAction(sender:)))
        let gesturePlayerTwo = UITapGestureRecognizer(target: self, action:  #selector(self.playerTwoAction(sender:)))
        let gestureOpening = UITapGestureRecognizer(target: self, action:  #selector(self.openingTapAction(sender:)))
        
        self.playerOneView.addGestureRecognizer(gesturePlayerOne)
        self.playerTwoView.addGestureRecognizer(gesturePlayerTwo)
        self.openingView.addGestureRecognizer(gestureOpening)
    }
        
    @objc func playerOneAction(sender : UITapGestureRecognizer) {
        if isPlayerOneTurn() {
            setPlayerMove(actualPlayerLabel: playerOneLabel, nextPlayerLabel: playerTwoLabel)
        }
    }
    
    @objc func playerTwoAction(sender : UITapGestureRecognizer) {
        if isPlayerTwoTurn() {
            setPlayerMove(actualPlayerLabel: playerTwoLabel, nextPlayerLabel: playerOneLabel)
        }
    }
    
    @objc func openingTapAction(sender : UITapGestureRecognizer) {
        setupRandomOpening()
    }
    
    func setPlayerMove(actualPlayerLabel: UILabel, nextPlayerLabel: UILabel) {
        if isOpeningComplete() {
            setNewOpeningTexts(actualPlayerLabel: playerTwoLabel)
        } else {
            actualPlayerLabel.text = String(self.openingComponents[turnCounter])
            nextPlayerLabel.text = NSLocalizedString("Opening_Tap", comment: String.Empty)
            turnCounter = turnCounter + 1
        }
    }
    
    func setNewOpeningTexts(actualPlayerLabel: UILabel) {
        openingLabel.text =  NSLocalizedString("Opening_NextOpening_Label", comment: String.Empty)
        actualPlayerLabel.text = String.Empty
        openingView.isUserInteractionEnabled = true
    }
    
    func isPlayerOneTurn() -> Bool {
        return turnCounter  % FileConstants.turnDivider == FileConstants.playerOneTurnDivider
    }
    
    func isPlayerTwoTurn() -> Bool {
        return turnCounter  % FileConstants.turnDivider == FileConstants.playerTwoTurnDivider
    }
    
    func isOpeningComplete() -> Bool {
        return turnCounter ==  openingMoves
    }
}
