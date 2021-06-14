//
//  AstronomyInformationResponse.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

struct AstronomyInformationResponse: Decodable {
  let date: String
  let explaination: String
  let hdUrl: String
  let mediaType: String
  let serviceVersion: String
  let title: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case date = "date"
    case explaination = "explanation"
    case hdUrl = "hdurl"
    case mediaType = "media_type"
    case serviceVersion = "service_version"
    case title = "title"
    case url = "url"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    date = try container.decode(String.self, forKey: .date)
    explaination = try container.decode(String.self, forKey: .explaination)
    hdUrl = try container.decode(String.self, forKey: .hdUrl)
    mediaType = try container.decode(String.self, forKey: .mediaType)
    serviceVersion = try container.decode(String.self, forKey: .serviceVersion)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decode(String.self, forKey: .url)
  }
}
