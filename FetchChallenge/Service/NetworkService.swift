//
//  NetworkService.swift
//  FetchChallenge
//
//  Created by S J on 1/8/24.
//

import Foundation

protocol NetworkServiceProtocol: Sendable {
  func fetchData<T: Codable>(endpoint: Endpoints) async -> Result<T,NetworkService.NetworkServiceError>
}

final class NetworkService: NetworkServiceProtocol {
  enum NetworkServiceError: Error {
    case urlNotValid
    case unableToDecode
    case backendServiceError
    case emptyData
  }

  func fetchData<T: Codable>(endpoint: Endpoints) async -> Result<T,NetworkService.NetworkServiceError> {
    guard let urlRequest = endpoint.createUrlRequest() else { return .failure(.urlNotValid) }
    do {
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      do {
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return .success(decoded)
      } catch {
        print(error)
        return .failure(.unableToDecode)
      }
    } catch {
      return .failure(.backendServiceError)
    }
  }
}
