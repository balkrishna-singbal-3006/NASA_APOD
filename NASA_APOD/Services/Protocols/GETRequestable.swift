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
        
        // Grab from cache
        guard let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request),
              let httpResponse = cachedResponse.response as? HTTPURLResponse,
              let date = httpResponse.value(forHTTPHeaderField: "Date") else {
          
          completion(.failure(error!))
          return
        }
        
        // 1. If the cached response date is today -> pass cached response.
        if self.isCachedDateTodays(dateString: date) {
          self.processResponse(data: cachedResponse.data, completion: completion)
        }
        // 2. If the cached response date is not today -> show alert & pass cached response.
        else {
          self.processResponse(data: cachedResponse.data) { (result) in
            
            switch result {
            
            case .success(let decodedResponse):
              completion(.success(decodedResponse))
              completion(.failure(error!)) // to show the alert
            
            case .failure(let error):
              completion(.failure(error))
            }
          }
        }
        return
      }
      
      // Success
      self.processResponse(data: data!, completion: completion)
    }
    task.resume()
  }
  
  private func isCachedDateTodays(dateString: String) -> Bool {
    
    guard let cachedDate = dateString.toDate(format: "E, d MMM yyyy HH:mm:ss Z") else {
      return false
    }
    
    return Calendar.current.isDateInToday(cachedDate)
  }
  
  private func processResponse(data: Data, completion: @escaping (Result<ResponseType, Error>) -> ()) {
    do {
      let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data)
      completion(.success(decodedResponse))
    } catch {
      completion(.failure(error))
    }
  }
}

extension String {
  
  func toDate(format: String) -> Date? {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = format
    
    guard let cachedDate = dateformatter.date(from: self) else {
      return nil
    }
    return cachedDate
  }
}
