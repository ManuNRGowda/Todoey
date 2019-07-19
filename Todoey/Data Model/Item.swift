//
//  Item.swift
//  Todoey
//
//  Created by Manu Gowda N R on 7/19/19.
//  Copyright © 2019 i-exceed. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
