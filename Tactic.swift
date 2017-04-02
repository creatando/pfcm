//
//  Tactic.swift
//  PFCM
//
//  Created by Thomas Anderson on 21/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import Foundation
import RealmSwift

class Tactic: Object {
    dynamic var tid = ""
    dynamic var tacticName = ""
    dynamic var date = NSDate()
    dynamic var annotationLink = ""
    
    var _gkCoord = List<TacticCoordinates>()
    var _p2Coord = List<TacticCoordinates>()
    var _p3Coord = List<TacticCoordinates>()
    var _p4Coord = List<TacticCoordinates>()
    var _p5Coord = List<TacticCoordinates>()
    var _p6Coord = List<TacticCoordinates>()
    var _p7Coord = List<TacticCoordinates>()
    var _p8Coord = List<TacticCoordinates>()
    var _p9Coord = List<TacticCoordinates>()
    var _p10Coord = List<TacticCoordinates>()
    var _p11Coord = List<TacticCoordinates>()

    override class func primaryKey () -> String? {
        return "tid"
    }
    
    //setting list maps
    
    var gkCoord: [Double] {
        get {
            return _gkCoord.map { $0.doubleValue }
        }
        set {
            _gkCoord.removeAll()
            _gkCoord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p2Coord: [Double] {
        get {
            return _p2Coord.map { $0.doubleValue }
        }
        set {
            _p2Coord.removeAll()
            _p2Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p3Coord: [Double] {
        get {
            return _p3Coord.map { $0.doubleValue }
        }
        set {
            _p3Coord.removeAll()
            _p3Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p4Coord: [Double] {
        get {
            return _p4Coord.map { $0.doubleValue }
        }
        set {
            _p4Coord.removeAll()
            _p4Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p5Coord: [Double] {
        get {
            return _p5Coord.map { $0.doubleValue }
        }
        set {
            _p5Coord.removeAll()
            _p5Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p6Coord: [Double] {
        get {
            return _p6Coord.map { $0.doubleValue }
        }
        set {
            _p6Coord.removeAll()
            _p6Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p7Coord: [Double] {
        get {
            return _p7Coord.map { $0.doubleValue }
        }
        set {
            _p7Coord.removeAll()
            _p7Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p8Coord: [Double] {
        get {
            return _p8Coord.map { $0.doubleValue }
        }
        set {
            _p8Coord.removeAll()
            _p8Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p9Coord: [Double] {
        get {
            return _p9Coord.map { $0.doubleValue }
        }
        set {
            _p9Coord.removeAll()
            _p9Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p10Coord: [Double] {
        get {
            return _p10Coord.map { $0.doubleValue }
        }
        set {
            _p10Coord.removeAll()
            _p10Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    var p11Coord: [Double] {
        get {
            return _p11Coord.map { $0.doubleValue }
        }
        set {
            _p11Coord.removeAll()
            _p11Coord.append(objectsIn: newValue.map({ TacticCoordinates(value: [$0]) }))
        }
    }
    
    override class func ignoredProperties() -> [String] {
        return ["gkCoord", "p2Coord", "p3Coord", "p4Coord", "p5Coord", "p6Coord", "p7Coord", "p8Coord", "p9Coord", "p10Coord", "p11Coord"]
    }
}

class TacticCoordinates: Object {
    dynamic var doubleValue: Double = 0.0
}
