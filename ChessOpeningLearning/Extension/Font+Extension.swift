//
//  Font+Extension.swift
//  ChessOpeningLearning
//
//  Created by Pablo Murnikovas on 7/3/21.
//  Copyright © 2021 Pablo Murnikovas. All rights reserved.
//

import Foundation
import UIKit

public struct Font {
    static let sfFontRegular = "SFUIText-Regular"
    static let sfFontBold = "SFUIText-Bold"
}

public extension UIFont {
    static let sfRegularFontOfSize18 = UIFont(name: Font.sfFontRegular, size: 18)!
    static let sfBoldFontOfSize32 = UIFont(name: Font.sfFontBold, size: 32)!
}
