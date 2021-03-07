//
//  String+Extension.swift
//  ChessOpeningLearning
//
//  Created by Pablo Murnikovas on 7/3/21.
//  Copyright © 2021 Pablo Murnikovas. All rights reserved.
//

public struct ChessPieces {
    static let PawnIcon = "♙"
    static let BishopIcon = "♗"
    static let KnightIcon = "♘"
    static let KingIcon = "♔"
    static let QueenIcon = "♕"
    static let RookIcon = "♖"
}

public extension String {
    static let Empty = ""
    static let Space = " "
    
    func formatWithChessIcons() -> String {
        var ret: String = self
        ret = ret.replacingOccurrences(of: "N", with: ChessPieces.KnightIcon, options: .literal, range: nil)
        ret = ret.replacingOccurrences(of: "B", with: ChessPieces.BishopIcon, options: .literal, range: nil)
        ret = ret.replacingOccurrences(of: "Q", with: ChessPieces.QueenIcon, options: .literal, range: nil)
        ret = ret.replacingOccurrences(of: "R", with: ChessPieces.RookIcon, options: .literal, range: nil)
        ret = ret.replacingOccurrences(of: "K", with: ChessPieces.KingIcon, options: .literal, range: nil)
        
        return ret
    }
}

