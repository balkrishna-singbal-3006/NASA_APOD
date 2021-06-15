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
  
  init(viewController: AstronomyInformationViewControllerDelegate,
       coordinator: Coordinator) {
    self.viewController = viewController
    self.coordinator = coordinator
  }
  
  func fetchAstronomyInformation() {
    
    self.viewController?.showActivityIndicator()
    
    let request = FetchAstronomyInformationRequest()
    request.execute(completion: { [weak self] (result) in
      
      guard let strongSelf = self else { return }
            
      switch result {
      
      case .success(let response):
        DispatchQueue.main.async {
          strongSelf.viewController?.hideActivityIndicator()
          strongSelf.viewController?.updateAstronomyInformationView(title: response.title,
                                                                    explaination: response.explaination,
                                                                    image: response.url)
        }
        
      case .failure(let error):
        DispatchQueue.main.async {
          strongSelf.viewController?.hideActivityIndicator()
          strongSelf.coordinator?.showAlert(title: "Error", message: error.localizedDescription, handler: nil)
        }
      }
    })
  }
}
