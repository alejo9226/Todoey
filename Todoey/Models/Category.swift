//
//  Category.swift
//  Todoey
//
//  Created by Alejandro Alfaro on 21/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>()
}
