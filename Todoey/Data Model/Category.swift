//
//  Category.swift
//  Todoey
//
//  Created by Manu Gowda N R on 7/19/19.
//  Copyright © 2019 i-exceed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
