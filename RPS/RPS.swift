//
//  RPS.swift
//  Prisoner's Dilemma
//
//  Created by SoundAppraisal on 19/02/16.
//  Copyright (c) 2016 Niels Taatgen. All rights reserved.
//

import Foundation
import UIKit


enum RPSAction {
    case Rock, Paper, Scissors
    
    var beats: RPSAction {
        switch self {
        case .Rock: return .Scissors
        case .Paper: return .Rock
        case .Scissors: return .Paper
        }
    }
    
    var name: String {
        switch self {
        case .Rock: return "rock"
        case .Paper: return "paper"
        case .Scissors: return "scissors"
        }
    }
    
    static func fromName(name: String) -> RPSAction? {
        switch name {
        case "rock": return .Rock
        case "paper": return .Paper
        case "scissors": return .Scissors
        default: return nil
        }
    }
}

enum RPSResult {
    case LWin, RWin, Tie
}

class RPSGame {
    var lScore: Int = 0
    var rScore: Int = 0
    
    static func getResult(lAction: RPSAction, _ rAction: RPSAction) -> RPSResult {
        if lAction == rAction {
            return .Tie
        } else if lAction.beats == rAction {
            return .LWin
        } else {
            return .RWin
        }
    }
    func reset() {
        self.lScore = 0
        self.rScore = 0
    }
}

class RPSViewController: UIViewController {
    var model = Model()
    var game = RPSGame()
    @IBOutlet weak var lResultImage: UIImageView!
    @IBOutlet weak var rResultImage: UIImageView!
    @IBOutlet weak var lLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        model.loadModel("rps")
        model.run()
    }
    
    @IBAction func chooseRock() {decide(.Rock)}
    @IBAction func choosePaper() {decide(.Paper)}
    @IBAction func chooseScissors() {decide(.Scissors)}
    
    func decide(playerchoice: RPSAction) {
        print("Here?")
        var modelchoice: RPSAction = .Rock
        // Only do something if there is a model and that model is waiting for the player to take an action
        if model.waitingForAction && model.actionChunk() {
            model.modifyLastAction("opponent", value: playerchoice.name)
            modelchoice = RPSAction.fromName(model.lastAction("choice")!)!
            
            lResultImage.image = UIImage(named: playerchoice.name)
            rResultImage.image = UIImage(named: "\(modelchoice.name)-opponent")
            
            print("Player chose \(playerchoice.name), model chose \(modelchoice.name)")
            
            switch(RPSGame.getResult(playerchoice, modelchoice)){
            case .LWin:
                game.lScore += 1
                result.text = "You win!"
            case .RWin:
                game.rScore += 1
                result.text = "You lose!"
            case .Tie:
                result.text = "Tie!"
            }
            lLabel.text = "You: \(game.lScore)"
            rLabel.text = "Opp: \(game.rScore)"
            
            
            model.time += 2.0
            model.run()
        }
    }
    
    func run() {
        if !model.running {
            model.clearTrace()
            model.run()
        }
    }
}