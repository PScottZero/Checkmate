//
//  Piece+CoreDataProperties.swift
//  Checkmate
//
//  Created by Paul Scott on 12/7/20.
//
//

import Foundation
import CoreData


extension Piece {

    public class func fetchRequest() -> NSFetchRequest<Piece> {
        NSFetchRequest<Piece>(entityName: "Piece")
    }

    @NSManaged public var belongsToPlayer1: Bool
    @NSManaged public var canTakeEnPassant: Bool
    @NSManaged public var column: Int16
    @NSManaged public var moveCount: Int16
    @NSManaged public var row: Int16
    @NSManaged public var type: String
    @NSManaged public var isInGame: GameSave?

}

extension Piece : Identifiable {

}
