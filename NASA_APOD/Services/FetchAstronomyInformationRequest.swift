//
//  FetchAstronomyInformationRequest.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

class FetchAstronomyInformationRequest: GETRequestable {
  
  typealias ResponseType = AstronomyInformationResponse

  var endpoint: String = "https://api.nasa.gov/planetary/apod?api_key=MPWAW9EG61juVkcQUR95pfDi2al7ofe2TrfL38Mk"
  
  var request: URLRequest
  
  /**
   Initializes the service to fetch astronomy information.
   */
  init() {
    request = URLRequest(url: URL(string: endpoint)!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  }
}
