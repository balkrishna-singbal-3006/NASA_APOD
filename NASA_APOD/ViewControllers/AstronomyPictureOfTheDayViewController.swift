//
//  ViewController.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import UIKit

protocol AstronomyPictureOfTheDayViewControllerDelegate: class {
  
  func updateAstronomyInformationView(title: String,
                                      explaination: String,
                                      image: String)
}

class AstronomyPictureOfTheDayViewController: UIViewController {

  // MARK:- IBOutlets
  @IBOutlet weak var astronomyImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var explainationLabel: UILabel!
  
  // MARK:- Properties
  private lazy var viewModel: AstronomyPictureOfTheDayViewModelDelegate =  {
    let viewModel = AstronomyPictureOfTheDayViewModel(viewController: self)
    return viewModel
  }()
  
  // MARK:- Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // fetch astronomy information
    viewModel.fetchAstronomyInformation()
  }
  
}

// MARK:- AstronomyPictureOfTheDayViewControllerDelegate methods
extension AstronomyPictureOfTheDayViewController: AstronomyPictureOfTheDayViewControllerDelegate {
  
  func updateAstronomyInformationView(title: String,
                                      explaination: String,
                                      image: String) {
    
    self.titleLabel.text = title
    self.explainationLabel.text = explaination
    self.astronomyImageView.downloaded(from: URL(string: image)!)
      
  }
}

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
