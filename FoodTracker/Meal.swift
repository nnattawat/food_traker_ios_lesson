//
//  Meal.swift
//  FoodTracker
//
//  Created by Nattawat Nonsung on 14/7/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class Meal {

  // MARK: Properties
  var name: String
  var photo: UIImage?
  var rating: Int

  // init? means that this init can be fail to init the object
  init?(name: String, photo: UIImage?, rating: Int) {
    // The name must not be empty
    guard !name.isEmpty else {
      return nil
    }

    // The rating must be between 0 and 5 inclusively
    guard (rating >= 0) && (rating <= 5) else {
      return nil
    }

    self.name = name
    self.photo = photo
    self.rating = rating
  }

}
