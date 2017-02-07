//
//  Player.swift
//  PFCM
//
//  Created by Thomas Anderson on 06/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct Player: NSObject{
    var ref:FIRDatabaseReference
    //fields
    var pid: String
    var firstName: String
    var lastName: String
    var dob: Date
    var address1: String
    var address2: String
    var city: String
    var postCode: String
    var position: String
    var position2: String
    var position3: String
    var squadNo: String
    var appearances: String
    var goals: String
    var assists: String
    
    init(pid: String = "", firstName: String, lastName: String, dob: Date, address1: String, address2: String, city: String, postCode: String, position: String, position2: String, position3: String, squadNo: String, appearances: String, goals: String, assists: String) {
        
        self.pid = pid
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.postCode = postCode
        self.position = position
        self.position2 = position2
        self.position3 = position3
        self.squadNo = squadNo
        self.appearances = appearances
        self.goals = goals
        self.assists = assists
        self.ref = FIRDatabase.database().reference()
    }
    

    init (snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as? NSDictionary
        self.pid = snapshotValue.key
        self.firstName = snapshotValue["firstName"]
        self.lastName = snapshotValue["lastName"]
        self.dob = snapshotValue["dob"]
        self.address1 = snapshotValue["address1"]
        self.address2 = snapshotValue["address2"]
        self.city = snapshotValue["city"]
        self.postCode = snapshotValue["postCode"]
        self.position = snapshotValue["position"]
        self.position2 = snapshotValue["position2"]
        self.position3 = snapshotValue["position3"]
        self.squadNo = snapshotValue["squadNo"]
        self.appearances = snapshotValue[""]
        self.goals = snapshotValue[""]
        self.assists = snapshotValue[""]
    }
    
    func toAnyObject() -> [String: Any] {
        return ["firstName": firstName, "lastName": lastName, "dob": dob, "address1": address1, "address2": address2, "postCode": postCode, "postion": position, "postion": position, "postion2": position2, "postion3": position3, "appearances": appearances, "goals": goals, "assists": assists]
    }
    
}
