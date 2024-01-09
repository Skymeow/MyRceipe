//
//  ContentView.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import SwiftUI

struct MealsContentView: View {

  @StateObject var viewModel = FetchMealsViewModel()

  var body: some View {
    VStack {
      ScrollView {
        switch viewModel.dataState {
        case .succeed:
          succeedBodyView
        case .failure:
          Text("Can't load your meals, please try later")
        case .inprogress, .initial:
          ProgressView()
            .padding()
        }
      }
    }
    .task {
      Task {
        await viewModel.loadMeals()
      }
    }
    .alert(modal: $viewModel.alertViewModel)
    .padding()
  }

  var succeedBodyView: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(viewModel.meals) { meal in
        rowBody(title: meal.name, imageUrl: meal.imageURL)

        Divider()
      }
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

#Preview {
  MealsContentView()
}
