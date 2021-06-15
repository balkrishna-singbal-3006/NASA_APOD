//
//  Error+Extension.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import Foundation

extension Error {
  var isNotConnectedToInternetError: Bool {
    if let error = self as? URLError {
      return error.errorCode == URLError.Code.notConnectedToInternet.rawValue
    }
    return false
  }
}
