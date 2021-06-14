//
//  GETRequestable.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

protocol GETRequestable {
  
  associatedtype ResponseType: Decodable
  
  var request: URLRequest { get set }
  var endpoint: String { get set }
  func execute(completion: @escaping (Result<ResponseType, Error>) -> ())
}

extension GETRequestable {
  
  /**
   Executes the request.
   - parameter completion: The completion handler to call when the fetch request is complete.
   */
  func execute(completion: @escaping (Result<ResponseType, Error>) -> ()) {
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
      
      guard error == nil else {
        completion(.failure(error!))
        return
      }
      
      do {
        let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data!)
        completion(.success(decodedResponse))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
}
