//
//  Item.swift
//  Todoey
//
//  Created by Alejandro Alfaro on 30/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
  var id: UUID = UUID()
  var title: String
  var done: Bool = false

  init(title: String) {
    self.title = title
  }
}
