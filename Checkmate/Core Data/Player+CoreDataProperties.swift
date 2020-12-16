//
//  Player+CoreDataProperties.swift
//  Checkmate
//
//  Created by Paul Scott on 12/7/20.
//
//

import Foundation
import CoreData


extension Player {

    public class func fetchRequest() -> NSFetchRequest<Player> {
        NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var image: Data?
    @NSManaged public var losses: Int32
    @NSManaged public var name: String
    @NSManaged public var rating: Int32
    @NSManaged public var wins: Int32
    @NSManaged public var isPlayer1ForGame: Set<GameSave>
    @NSManaged public var isPlayer2ForGame: Set<GameSave>

}

// MARK: Generated accessors for isPlayer1ForGame
extension Player {

    @objc(addIsPlayer1ForGameObject:)
    @NSManaged public func addToIsPlayer1ForGame(_ value: GameSave)

    @objc(removeIsPlayer1ForGameObject:)
    @NSManaged public func removeFromIsPlayer1ForGame(_ value: GameSave)

    @objc(addIsPlayer1ForGame:)
    @NSManaged public func addToIsPlayer1ForGame(_ values: NSSet)

    @objc(removeIsPlayer1ForGame:)
    @NSManaged public func removeFromIsPlayer1ForGame(_ values: NSSet)

}

// MARK: Generated accessors for isPlayer2ForGame
extension Player {

    @objc(addIsPlayer2ForGameObject:)
    @NSManaged public func addToIsPlayer2ForGame(_ value: GameSave)

    @objc(removeIsPlayer2ForGameObject:)
    @NSManaged public func removeFromIsPlayer2ForGame(_ value: GameSave)

    @objc(addIsPlayer2ForGame:)
    @NSManaged public func addToIsPlayer2ForGame(_ values: NSSet)

    @objc(removeIsPlayer2ForGame:)
    @NSManaged public func removeFromIsPlayer2ForGame(_ values: NSSet)

}

extension Player : Identifiable {

}
