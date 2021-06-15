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
      
      guard error == nil else {
        DispatchQueue.main.async {
          self.image = self.getSavedImage(named: "astronomyPictureOfTheDay.png")
        }
        return
      }
      
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data,
        let image = UIImage(data: data)
      else {
        print("Returning from guard...")
        return }
      
      DispatchQueue.main.async() {
        self.image = image
        self.saveImage(image: image)
      }
    }.resume()
  }
  
  @discardableResult
  private func saveImage(image: UIImage) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
      return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
      return false
    }
    do {
      try data.write(to: directory.appendingPathComponent("astronomyPictureOfTheDay.png")!)
      print("### Saved image to Documents Directory....")
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
  
  private func getSavedImage(named: String) -> UIImage? {
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
      print("### Fetching image from Documents Directory....")
      return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    return nil
  }
}
