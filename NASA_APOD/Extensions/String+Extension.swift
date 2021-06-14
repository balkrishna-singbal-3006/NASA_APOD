//
//  String+Extension.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import Foundation

extension String {
  
  func toDate(format: String) -> Date? {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = format
    
    guard let date = dateformatter.date(from: self) else {
      return nil
    }
    return date
  }
}
