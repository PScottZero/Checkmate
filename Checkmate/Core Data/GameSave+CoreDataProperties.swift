//
//  GameSave+CoreDataProperties.swift
//  Checkmate
//
//  Created by Paul Scott on 12/7/20.
//
//

import Foundation
import CoreData


extension GameSave {

    public class func fetchRequest() -> NSFetchRequest<GameSave> {
        NSFetchRequest<GameSave>(entityName: "GameSave")
    }

    @NSManaged public var aiDifficulty: String?
    @NSManaged public var image: Data
    @NSManaged public var isPlayer1Turn: Bool
    @NSManaged public var player1TimeLeft: Int16
    @NSManaged public var player2TimeLeft: Int16
    @NSManaged public var playerIsFirst: Bool
    @NSManaged public var playingWithAI: Bool
    @NSManaged public var time: String
    @NSManaged public var timeLimit: Int16
    @NSManaged public var pieces: Set<Piece>
    @NSManaged public var player1: Player
    @NSManaged public var player2: Player?

}

// MARK: Generated accessors for pieces
extension GameSave {

    @objc(addPiecesObject:)
    @NSManaged public func addToPieces(_ value: Piece)

    @objc(removePiecesObject:)
    @NSManaged public func removeFromPieces(_ value: Piece)

    @objc(addPieces:)
    @NSManaged public func addToPieces(_ values: NSSet)

    @objc(removePieces:)
    @NSManaged public func removeFromPieces(_ values: NSSet)

}

extension GameSave : Identifiable {

}
