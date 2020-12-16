//
//  SharedFunctions.swift
//  Checkmate
//
//  Created by Paul Scott on 11/15/20.
//

import Foundation

struct SharedFunctions {
    static func isInTileList(tileList: [Tile], tile: Tile) -> Bool {
        tileListIndex(of: tile, in: tileList) != -1
    }
    
    static func tileListIndex(of tile: Tile, in tileList: [Tile]) -> Int {
        for (index, tileListElement) in tileList.enumerated() {
            if tileListElement == tile {
                return index
            }
        }
        return -1
    }
    
    static func tileInBounds(_ tile: Tile) -> Bool {
        (SKConstants.boardRange).contains(tile.0) && (SKConstants.boardRange).contains(tile.1);
    }
}
