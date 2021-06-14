//
//  UIImage+Extension.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

extension UIImageView {
  
  func downloaded(from url: URL) {
    self.contentMode = .scaleAspectFit
          URLSession.shared.dataTask(with: url) { data, response, error in
              guard
                  let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
                  else { return }
              DispatchQueue.main.async() { [weak self] in
                  self?.image = image
              }
          }.resume()
      }
}
