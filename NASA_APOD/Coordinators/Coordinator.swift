//
//  Coordinator.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

class Coordinator {
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
        
    // 1. Create View Controller
    let viewController = AstronomyInformationViewController.instantiate()
    viewController.title = "Astro Information"
    
    // 2. Create View Model
    let viewModel = AstronomyInformationViewModel(viewController: viewController)
    viewModel.viewController = viewController
    
    // 3. Assign View Model and Push View Controller
    viewController.viewModel = viewModel
    self.navigationController.pushViewController(viewController, animated: true)
  }
  
  func popBack() {
      self.navigationController.popViewController(animated: true)
  }
}
