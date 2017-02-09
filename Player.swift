//
//  Player.swift
//  PFCM
//
//  Created by Thomas Anderson on 08/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object {
    dynamic var pid = ""
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var dob = NSDate(timeIntervalSince1970: 1)
    dynamic var address1 = ""
    dynamic var address2 = ""
    dynamic var city = ""
    dynamic var postCode = ""
    dynamic var position = ""
    dynamic var position2 = ""
    dynamic var position3 = ""
    dynamic var squadNo = ""
    dynamic var appearances = 0
    dynamic var goals = 0
    dynamic var assists = 0
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
