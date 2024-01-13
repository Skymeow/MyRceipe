//
//  MealDetail.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import Foundation

struct DetailData: Codable {
  let meals: [MealDetail]
}

struct MealDetail: Codable, Hashable, Identifiable {
  let name: String
  let id: String
  let category: String
  let area: String
  let instructions: String
  let youtube: String

  enum CodingKeys: String, CodingKey {
    case name = "strMeal"
    case id = "idMeal"
    case category = "strCategory"
    case area = "strArea"
    case instructions = "strInstructions"
    case youtube = "strYoutube"
  }

  var youtubeUrl: URL? {
    URL(string: youtube)
  }
}
