//
//  File.swift
//  TippyApp
//
//  Created by Van Do on 9/24/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import Foundation
class Settings : NSObject, NSCoding {
    var darkTheme: Bool
    var percentArray: [Double]
    var defaultIndex: Int
    
    override init() {
        darkTheme = false
        defaultIndex = 0
        percentArray = [0.15, 0.2, 0.25]
    }
    
    required init(coder aDecoder: NSCoder) {
        self.darkTheme = aDecoder.decodeObjectForKey("darkTheme") as! Bool
        self.percentArray = aDecoder.decodeObjectForKey("percentArray") as! [Double]
        self.defaultIndex = aDecoder.decodeObjectForKey("defaultIndex") as! Int
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.darkTheme, forKey: "darkTheme")
        aCoder.encodeObject(self.percentArray, forKey: "percentArray")
        aCoder.encodeObject(self.defaultIndex, forKey: "defaultIndex")
    }
}