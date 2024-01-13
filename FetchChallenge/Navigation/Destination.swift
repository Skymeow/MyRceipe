//
//  Destination.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import Foundation
import SwiftUI

enum Destination: Hashable, View {
  case detail(detail: MealDetail)

  var body: some View {
    switch self {
    case .detail(let detail):
      DetailContentView(detail: detail)
    }
  }
}
