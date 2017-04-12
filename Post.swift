//
//  Post.swift
//  PFCM
//
//  Created by Thomas Anderson on 11/04/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let postID: String
    let caption: String
    let imageURL: String
    let likes: Int
    let timestamp: Any
    let ref: FIRDatabaseReference?
    
    
    init (postID: String, caption: String, imageURL: String, likes: Int, timestamp: Any) {
        
        self.postID = postID
        self.caption = caption
        self.imageURL = imageURL
        self.likes = likes
        self.timestamp = timestamp
        
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        postID = snapshot.key
        let snapshotValue = snapshot.value as! [String: Any]
        
        caption = snapshotValue["caption"] as! String
        imageURL = snapshotValue["imageURL"] as! String
        likes = snapshotValue["likes"] as! Int
        timestamp = snapshotValue["timestamp"] as Any
        
        ref = snapshot.ref
        
    }
    
    func toAny() -> Any {
        return [
            "caption": caption,
            "imageURL": imageURL,
            "likes": likes,
            "timestamp": timestamp
        ]
    }
}
