//
//  GameProtocol.swift
//  MiniGames
//
//  Created by Артур on 22.12.21.
//

import Foundation

protocol GameProtocol: AnyObject {
    // Обязательно представлять этот протокол как Weak
    var presenter: GamePresenterProtocol? { get set }
    var players: [SingleUserModel]? { get set }
    func sendResult(result: Double, index: Int?)
}
