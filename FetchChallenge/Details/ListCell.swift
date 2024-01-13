//
//  ListCell.swift
//  FetchChallenge
//
//  Created by S J on 1/13/24.
//

import SwiftUI

struct ListCell: View {
  let meal: Meal
  @EnvironmentObject var navigator: Navigator
  @StateObject private var viewModel = ListCellViewModel()

  var body: some View {
    VStack {
      Button {
        Task {
          await viewModel.loadDetail(id: meal.id)
          if let details = viewModel.details {
            navigator.navPath.append(.detail(detail: details))
          }
        }
      } label: {
        rowBody(title: meal.name, imageUrl: meal.imageURL)
      }

      Divider()
    }
  }

  @ViewBuilder
  func rowBody(title: String, imageUrl: URL?) -> some View {
    HStack(spacing: 0) {
        Text(title)
          .padding(10)

      Spacer()

        AsyncImage(url: imageUrl) { phase in
          if let image = phase.image {
            image
              .resizable()
              .frame(width: 70, height: 70)
              .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
          } else if phase.error != nil {
            EmptyView()
          } else {
            ProgressView()
          }
        }
        .padding(.trailing, 10)
    }
    .padding(.bottom, 16)
  }
}

//#Preview {
//  ListCell(title: "", imageUrl: <#URL?#>)
//}
