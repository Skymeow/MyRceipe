//
//  Dessert.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import Foundation

struct Meals: Codable {
  let meals: [Meal]
}

struct Meal: Codable, Identifiable {
  let name: String
  let id: String
  let image: String

  enum CodingKeys: String, CodingKey {
    case name = "strMeal"
    case id = "idMeal"
    case image = "strMealThumb"
  }

  var imageURL: URL? {
    URL(string: image)
  }
}
