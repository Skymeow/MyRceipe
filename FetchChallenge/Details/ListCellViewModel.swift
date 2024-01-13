//
//  ListCellViewModel.swift
//  FetchChallenge
//
//  Created by S J on 1/13/24.
//

import Foundation

class ListCellViewModel: ObservableObject {
  struct ErrorMessageConst {
      static let title = "Failed to load details"
      static let message = "Please try again later"
  }

  @Published var details: MealDetail? = nil
  private let servic: NetworkServiceProtocol
  @Published var alertViewModel: AlertViewModel? = nil

  init(details: MealDetail? = nil, servic: NetworkServiceProtocol = NetworkService()) {
    self.details = details
    self.servic = servic
  }

  @MainActor
  func loadDetail(id: String) async {
    guard details == nil else {
      return
    }
    let result: Result<DetailData, NetworkService.NetworkServiceError> = await servic.fetchData(endpoint: .detail(id: id))
    switch result {
    case .success(let details):
      if let detail = details.meals.first {
        self.details = detail
      } else {
        alertViewModel = .init(title: ListCellViewModel.ErrorMessageConst.title, message:  ListCellViewModel.ErrorMessageConst.message, onDismiss: {
          self.alertViewModel = nil
        })
      }
    case .failure:
      alertViewModel = .init(title: ListCellViewModel.ErrorMessageConst.title, message:  ListCellViewModel.ErrorMessageConst.message, onDismiss: {
        self.alertViewModel = nil
      })
    }
  }
}
