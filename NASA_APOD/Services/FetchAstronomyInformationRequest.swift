//
//  FetchAstronomyInformationRequest.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

class FetchAstronomyInformationRequest {
  
  private static let ENDPOINT = "https://api.nasa.gov/planetary/apod?api_key=MPWAW9EG61juVkcQUR95pfDi2al7ofe2TrfL38Mk"
  
  func execute(completion: @escaping (Result<AstronomyInformationResponse, Error>) -> ()) {
    let url = URL(string: FetchAstronomyInformationRequest.ENDPOINT)!
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      
//      print(String(data: data, encoding: .utf8)!)
      guard error == nil else {
        completion(.failure(error!))
        return
      }
      
      do {
        let decodedResponse = try JSONDecoder().decode(AstronomyInformationResponse.self, from: data!)
        completion(.success(decodedResponse))
      } catch {
        completion(.failure(error))
      }
      
    }
    task.resume()
  }
}
