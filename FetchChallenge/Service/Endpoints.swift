//
//  Endpoints.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import Foundation

enum Endpoints {
  case dessert
  case detail(id: String)

  private var baseUrl: String {
    switch self {
    case .dessert:
      "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    case .detail:
      "https://themealdb.com/api/json/v1/1/lookup.php"
    }
  }

  private var queryParameters: [String: String] {
    switch self {
    case .dessert:
      ["c": "Dessert"]
    case .detail(let id):
      ["i": id]
    }
  }

  func createUrlRequest() -> URLRequest? {
    guard var components = URLComponents(string: self.baseUrl) else { return nil }
    components.queryItems = self.queryParameters.map{ URLQueryItem(name: $0.key, value: $0.value) }
    guard let url = components.url else { return nil }
    return URLRequest(url: url)
  }
}

