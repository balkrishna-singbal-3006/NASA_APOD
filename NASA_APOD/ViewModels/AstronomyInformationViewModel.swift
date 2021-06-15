//
//  AstronomyInformationViewModel.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

protocol AstronomyInformationViewModelDelegate {
  
  var viewController: AstronomyInformationViewControllerDelegate? { get set }
  
  var coordinator: Coordinator? { get set }
  
  func fetchAstronomyInformation()
}

class AstronomyInformationViewModel: AstronomyInformationViewModelDelegate {
  
  weak var viewController: AstronomyInformationViewControllerDelegate?
  
  weak var coordinator: Coordinator?
  
  /**
   Initializes the AstronomyInformationViewMode .
   - parameter viewController: The view controller instance..
   - parameter coordinator: The coordinator instance.
   */
  init(viewController: AstronomyInformationViewControllerDelegate,
       coordinator: Coordinator) {
    self.viewController = viewController
    self.coordinator = coordinator
  }
  
  /**
   Makes an API call to fetch the astronomy information.
   */
  func fetchAstronomyInformation() {
    
    self.viewController?.showActivityIndicator()
    
    let request = FetchAstronomyInformationRequest()
    request.execute(completion: { [weak self] (result) in
      
      guard let strongSelf = self else { return }
            
      switch result {
      
      case .success(let response):
        DispatchQueue.main.async {
          strongSelf.viewController?.hideActivityIndicator()
        
          let imageURL: URL? = (response.url != nil) ? URL(string: response.url!) : nil
          
          strongSelf.viewController?.updateAstronomyInformationView(title: response.title,
                                                                    explanation: response.explanation,
                                                                    imageUrl: imageURL)
        }
        
      case .failure(let error):
        DispatchQueue.main.async {
          strongSelf.viewController?.hideActivityIndicator()
          
          if error.isNotConnectedToInternetError {
            strongSelf.coordinator?.showAlert(title: "Error",
                                              message: "We are not connected to the internet, showing you the last image we have.",
                                              handler: nil)
          }
          else {
            strongSelf.coordinator?.showAlert(title: "Error", message: error.localizedDescription, handler: nil)
          }
        }
      }
    })
  }
}
