//
//  AstronomyInformationViewController.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import UIKit

protocol AstronomyInformationViewControllerDelegate: ActivityIndicatorNotifiable {
  
  func updateAstronomyInformationView(title: String?,
                                      explanation: String?,
                                      imageUrl: URL?)
}

class AstronomyInformationViewController: UIViewController, Storyboarded {

  // MARK:- IBOutlets
  @IBOutlet weak var astronomyImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var explanationTextView: UITextView!
  
  // MARK:- Properties
  var indicator: UIActivityIndicatorView?
  var viewModel: AstronomyInformationViewModelDelegate!
  
  // MARK:- Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addActivityIndicator()
    
    // fetch astronomy information
    viewModel.fetchAstronomyInformation()
  }
}

// MARK:- AstronomyInformationViewControllerDelegate methods
extension AstronomyInformationViewController: AstronomyInformationViewControllerDelegate  {
  
  /**
   Updates the Astronomy Information.
   - parameter title: The title text.
   - parameter explanation: The explanation text.
   - parameter image: The image URL string.
   */
  func updateAstronomyInformationView(title: String?,
                                      explanation: String?,
                                      imageUrl: URL?) {
    
    self.titleLabel.text = title
    self.explanationTextView.text = explanation
    
    guard let url = imageUrl else { return }

    self.astronomyImageView.download(from: url)
  }
}
