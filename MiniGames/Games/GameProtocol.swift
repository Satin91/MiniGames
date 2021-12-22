//
//  GameProtocol.swift
//  MiniGames
//
//  Created by Артур on 22.12.21.
//

import Foundation

protocol GameProtocol {
    // Обязательно представлять этот протокол как Weak
    var gamePresenter: GamePresenterProtocol? { get set }
    func sendResult(result: Double)
}
