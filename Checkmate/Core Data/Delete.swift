//
//  Delete.swift
//  Checkmate
//
//  Created by Paul Scott on 12/7/20.
//

import Foundation
import CoreData

struct Delete {
    static let viewContext = PersistenceController.shared.container.viewContext
    
    static func gameSave(_ gameSave: GameSave) {
        for piece in Array(gameSave.pieces) {
            viewContext.delete(piece)
        }
        viewContext.delete(gameSave)
    }
    
    static func allGameSaves() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GameSave")
        do {
            let results = try viewContext.fetch(fetchRequest)
            for gameSave in results {
                Delete.gameSave(gameSave as! GameSave)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func piece(_ piece: Piece) {
        viewContext.delete(piece)
    }
    
    static func allPiecesFor(gameSave: GameSave) {
        for piece in gameSave.pieces {
            Delete.piece(piece)
        }
    }
    
    static func player(_ player: Player) {
        for gameSave in Array(player.isPlayer1ForGame) + Array(player.isPlayer2ForGame) {
            viewContext.delete(gameSave)
        }
        viewContext.delete(player)
    }
    
    static func allPlayers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Player")
        do {
            let results = try viewContext.fetch(fetchRequest)
            for player in results {
                Delete.player(player as! Player)
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
