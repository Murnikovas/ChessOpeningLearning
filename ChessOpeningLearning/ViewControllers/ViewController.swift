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
    static let playerOneTurnMod: Int = 0
    static let playerTwoTurnMod: Int = 1
    static let numbersOfViewInTheMainStack: CGFloat = 3.0
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var playerOneView: UIView!
    @IBOutlet private weak var playerTwoView: UIView!
    @IBOutlet private weak var playerOneLabel: UILabel!
    @IBOutlet private weak var playerTwoLabel: UILabel!
    @IBOutlet private weak var openingView: UIView!
    @IBOutlet private weak var openingLabel: UILabel!
    @IBOutlet private weak var playerOneViewHeightConstraint: NSLayoutConstraint!

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
        openings["Ruy Lopez"] = "1.e4 e5 2.Nf3 Nc6 3.Bb5"
        openings["Queen's Gambit"] = "1.d4 d5 2.c4"
        openings["Hungarian Def."] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Be7"
        openings["Two Knights Def."] = "1.e4 e5 2.Nf3 Nc6 3.Bc4 Nf6"
        openings["Sicilian - Dragon"] = "1.e4 c5  2.Nf3 d6  3.d4 cxd4 4.Nxd4 Nf6  5.Nc3 g6"
        openings["Adelaide Gambit"] = "1.e4 e5 2.f4 Nc6 3.Nf3 f5"
        openings["Benoni Def."] = "1.d4 Nf6 2.c4 c5 3.d5"
        openings["Bogo Indian Def."] = "1.d4 Nf6 2.c4 e6 3.Nf3 Bb4+"
        openings["Catalan Opening"] = "1.d4 Nf6 2.c4 e6 3.g3"
        openings["Four Knights"] = "1.e4 e5 2.Nf3 Nc6 3.Nc3 Nf6"
        openings["Scotch Game"] = "1.e4 e5 2.Nf3 Nc6 3.d4"
        openings["Queen's Indian Def."] = "1.d4 Nf6 2.c4 e6 3.Nf3 b6"
        openings["Grünfeld Def."] = "1.d4 Nf6 2.c4 g6 3.Nc3 d5"
        openings["Danish Gambit"] = "1.e4 e5 2.d4 exd4 3.c3"
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
            playerOneView.isUserInteractionEnabled = true
            playerTwoView.isUserInteractionEnabled = true
            self.setupTexts()
        }
    }
    
    func setupViews() {
        playerOneViewHeightConstraint.constant = UIScreen.main.bounds.height / FileConstants.numbersOfViewInTheMainStack
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
        actualPlayerLabel.text = String(self.openingComponents[turnCounter]).formatWithChessIcons()
        nextPlayerLabel.text = NSLocalizedString("Opening_Tap", comment: String.Empty)
        turnCounter = turnCounter + 1
            
        if isOpeningComplete() {
            playerOneView.isUserInteractionEnabled = false
            playerTwoView.isUserInteractionEnabled = false
            openingView.isUserInteractionEnabled = true
            setNewOpeningTexts(nextPlayerLabel: nextPlayerLabel)
        }
    }
    
    func setNewOpeningTexts(nextPlayerLabel: UILabel) {
        openingLabel.text =  NSLocalizedString("Opening_NextOpening_Label", comment: String.Empty)
        nextPlayerLabel.text = String.Empty
    }
    
    func isPlayerOneTurn() -> Bool {
        return turnCounter  % FileConstants.turnDivider == FileConstants.playerOneTurnMod
    }
    
    func isPlayerTwoTurn() -> Bool {
        return turnCounter  % FileConstants.turnDivider == FileConstants.playerTwoTurnMod
    }
    
    func isOpeningComplete() -> Bool {
        return turnCounter ==  openingMoves
    }
}
