//
//  NetworkService.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
  func fetchDessert() async -> Result<Meals, NetworkService.NetworkServiceError>
}

final class NetworkService: NetworkServiceProtocol {
  enum NetworkServiceError: Error {
    case urlNotValid
    case unableToDecode
    case backendServiceError
  }

  func fetchDessert() async -> Result<Meals, NetworkService.NetworkServiceError> {
    guard let url = URL(string: Endpoints.dessert.rawValue) else { return .failure(.urlNotValid) }
    do {
      let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
      do {
        let meals = try JSONDecoder().decode(Meals.self, from: data)
        return .success(meals)
      } catch {
        print(error)
        return .failure(.unableToDecode)
      }
    } catch {
      return .failure(.backendServiceError)
    }
  }
}
