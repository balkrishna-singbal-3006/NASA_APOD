//
//  Coordinator.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

class Coordinator {
  
  let navigationController: UINavigationController
  
  // MARK:- Initializer
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
        
    // 1. Create View Controller
    let viewController = AstronomyInformationViewController.instantiate()
    viewController.title = "Astro Information"
    
    // 2. Create View Model
    let viewModel = AstronomyInformationViewModel(viewController: viewController,
                                                  coordinator: self)
    viewModel.viewController = viewController
    
    // 3. Assign View Model and Push View Controller
    viewController.viewModel = viewModel
    self.navigationController.pushViewController(viewController, animated: true)
  }
  
  func popBack() {
      self.navigationController.popViewController(animated: true)
  }
  
  func showAlert(title: String, message: String, handler: (() -> Void)?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
          handler?()
      }))
      self.navigationController.present(alertController, animated: true, completion: nil)
  }
}
