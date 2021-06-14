//
//  AstronomyInformationViewController.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import UIKit

protocol AstronomyInformationViewControllerDelegate: class {
  
  func updateAstronomyInformationView(title: String,
                                      explaination: String,
                                      image: String)
}

class AstronomyInformationViewController: UIViewController {

  // MARK:- IBOutlets
  @IBOutlet weak var astronomyImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var explainationLabel: UILabel!
  
  // MARK:- Properties
  var viewModel: AstronomyInformationViewModelDelegate!
  
  // MARK:- Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // fetch astronomy information
    viewModel.fetchAstronomyInformation()
  }
  
}

// MARK:- AstronomyInformationViewControllerDelegate methods
extension AstronomyInformationViewController: AstronomyInformationViewControllerDelegate, Storyboarded {
  
  func updateAstronomyInformationView(title: String,
                                      explaination: String,
                                      image: String) {
    
    self.titleLabel.text = title
    self.explainationLabel.text = explaination
    self.astronomyImageView.downloaded(from: URL(string: image)!)
      
  }
}
