//
//  superheroCollectionModel.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import Foundation
import Firebase

struct superheroCollectionModel {
    let ref: DatabaseReference?
    let key: String
    let id: String
    let name: String
    let publisher: String
    let alignment: String
    let image: String
    
    // MARK: Initialize with Raw Data
    init(id: String, name: String, publisher: String, alignment: String, image: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.id = id
        self.name = name
        self.publisher = publisher
        self.alignment = alignment
        self.image = image
    }
    
    // MARK: Initialize with Firebase DataSnapshot
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? String,
            let name = value["name"] as? String,
            let publisher = value["publisher"] as? String,
            let alignment = value["alignment"] as? String,
            let image = value["image"] as? String
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = id
        self.name = name
        self.publisher = publisher
        self.alignment = alignment
        self.image = image
    }
    
    // MARK: Convert to AnyObject
    func toAnyObject() -> NSDictionary {
        return [
            "id": id,
            "name": name,
            "publisher": publisher,
            "alignment": alignment,
            "image": image
        ]
    }
}
