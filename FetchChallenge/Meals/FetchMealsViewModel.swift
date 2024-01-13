//
//  FetchMealsViewModel.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import Foundation

class FetchMealsViewModel: ObservableObject {

  struct ErrorMessageConst {
      static let title = "Failed to load meals"
      static let message = "Please try again later"
  }

  enum FetchMealDataState {
    case succeed
    case failure
    case inprogress
    case initial
  }

  private let servic: NetworkServiceProtocol
  @Published var meals: [Meal] = []
  @Published var dataState: FetchMealDataState = .initial
  @Published var alertViewModel: AlertViewModel? = nil
  @Published var isFirstAppear: Bool = true
  @Published var details: MealDetail? = nil
  

  init(servic: NetworkServiceProtocol = NetworkService()) {
    self.servic = servic
  }

  @MainActor
  func loadMeals() async {
    dataState = .inprogress
    let result: Result<Meals, NetworkService.NetworkServiceError> = await servic.fetchData(endpoint: .dessert)
    switch result {
    case .success(let meals):
      self.meals = meals.meals
      dataState = .succeed
      isFirstAppear = false
    case .failure:
      dataState = .failure
      alertViewModel = .init(title: FetchMealsViewModel.ErrorMessageConst.title, message:  FetchMealsViewModel.ErrorMessageConst.message, onDismiss: {
        self.alertViewModel = nil
      })
    }
  }
}
