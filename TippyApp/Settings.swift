//
//  File.swift
//  TippyApp
//
//  Created by Van Do on 9/24/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import Foundation
class Settings {
    var darkTheme: Bool
    var percentArray: [Double]
    var defaultIndex: Int
    
    init() {
        darkTheme = false
        defaultIndex = 0
        percentArray = [0.15, 0.2, 0.25]
    }
}