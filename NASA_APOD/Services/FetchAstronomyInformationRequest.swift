//
//  FetchAstronomyInformationRequest.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

class FetchAstronomyInformationRequest: GETRequestable {
  
  typealias ResponseType = AstronomyInformationResponse
  
  var endpoint: String = "https://api.nasa.gov/planetary/apod"
  
  var request: URLRequest
  
  private let apiKey: String = "MPWAW9EG61juVkcQUR95pfDi2al7ofe2TrfL38Mk"
  
  /**
   Initializes the service to fetch astronomy information.
   */
  init() {
    
    var urlComponents = URLComponents(string: endpoint)!
    urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
    
    request = URLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  }
}
