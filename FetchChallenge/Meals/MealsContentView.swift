//
//  ContentView.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import SwiftUI

struct MealsContentView: View {

  @StateObject var viewModel = FetchMealsViewModel()
  @StateObject var navigator = Navigator()

  var body: some View {
    NavigationStack(path: $navigator.navPath) {
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
      .navigationDestination(for: Destination.self, destination: {$0})
      .task {
        guard viewModel.isFirstAppear else { return }
        await viewModel.loadMeals()
      }
      .alert(modal: $viewModel.alertViewModel)
      .padding()
    }
    .environmentObject(navigator)
  }

  var succeedBodyView: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(viewModel.meals) { meal in
        ListCell(meal: meal)
      }
    }
  }
}

#Preview {
  MealsContentView()
}
