//
//  DetailContentView.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import SwiftUI

struct DetailContentView: View {
  let detail: MealDetail

  init(detail: MealDetail) {
    self.detail = detail
  }

  var body: some View {
    Text(detail.name)
      .font(.title)

    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Text("Instructions:")
          .font(.headline)
          .padding(.bottom, 5)

        if let url = detail.youtubeUrl {
          YoutubeView(videoURL: url)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .padding()
        }

        Text(detail.instructions)
          .multilineTextAlignment(.leading)
      }
      .padding(12)
    }
  }

}

#Preview {
  DetailContentView(detail: MealDetail(name: "test", id: "1", category: "cook", area: "Asia", instructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.", youtube: ""))
}
