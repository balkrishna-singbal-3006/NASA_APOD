//
//  AstronomyInformationViewModel.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 14/06/21.
//

import Foundation

protocol AstronomyInformationViewModelDelegate {
  
  var viewController: AstronomyInformationViewControllerDelegate? { get set }
  
  func fetchAstronomyInformation()
}

class AstronomyInformationViewModel: AstronomyInformationViewModelDelegate {
  
  weak var viewController: AstronomyInformationViewControllerDelegate?
  
  init(viewController: AstronomyInformationViewControllerDelegate) {
    self.viewController = viewController
  }
  
  func fetchAstronomyInformation() {
    
    let request = FetchAstronomyInformationRequest()
    request.execute(completion: { [weak self] (result) in
      
      guard let strongSelf = self else { return }
      
      switch result {
      
      case .success(let response):
        DispatchQueue.main.async {
          strongSelf.viewController?.updateAstronomyInformationView(title: response.title,
                                                                    explaination: response.explaination,
                                                                    image: response.url)
        }
        
      case .failure(let error): break
        // TODO:- show an alert
      }
      
    })
  }
}
