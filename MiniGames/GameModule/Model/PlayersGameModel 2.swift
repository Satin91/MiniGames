//
//  GameModel.swift
//  MiniGames
//
//  Created by Артур on 22.12.21.
//

import Foundation


struct GameModel {
    var rounds: Int
    var currentRound: Int
}

struct PlayersGameModel {
    var name: String
    var score: Double
    var index: Int? // В играх, где нет перехода, индекс равен nil
}

