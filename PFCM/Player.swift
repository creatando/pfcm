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
    dynamic var pid = NSUUID().uuidString
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var dob = ""
    dynamic var phoneNo = ""
    dynamic var emailAdd = ""
    dynamic var address1 = ""
    dynamic var address2 = ""
    dynamic var city = ""
    dynamic var postCode = ""
    dynamic var position = ""
    dynamic var position2 = ""
    dynamic var position3 = ""
    dynamic var squadNo = ""
    dynamic var appearances = ""
    dynamic var goals = ""
    dynamic var assists = ""
    
    override class func primaryKey () -> String? {
        return "pid"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//override static func ignoredProperties() -> [String] {
//        //return ["appearances","goals","assists"]
//    return[]
//    }
}
