//
//  Coordinator.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

class Coordinator {
  
  struct NavigationTitles {
    static let AstronomyInformationViewControllerTitle = "Astro Information"
  }
  
  // MARK:- Constants
  let navigationController: UINavigationController
  
  // MARK:- Initializer
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  /**
   Starts the coordinator.
   */
  func start() {
        
    // 1. Create View Controller
    let viewController = AstronomyInformationViewController.instantiate()
    viewController.title = NavigationTitles.AstronomyInformationViewControllerTitle
    
    // 2. Create View Model
    let viewModel = AstronomyInformationViewModel(viewController: viewController,
                                                  coordinator: self)
    viewModel.viewController = viewController
    
    // 3. Assign View Model and Push View Controller
    viewController.viewModel = viewModel
    self.navigationController.pushViewController(viewController, animated: true)
  }
  
  /**
    Pops the view controller from the navigation stack.
   */
  func popBack() {
      self.navigationController.popViewController(animated: true)
  }
  
  /**
   Displays an alert.
   - parameter title: Alert title to be displayed.
   - parameter message: Alert message to be displayed.
   - parameter handler: Callback on tap of alert's action button.
   */
  func showAlert(title: String, message: String, handler: (() -> Void)?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
          handler?()
      }))
      self.navigationController.present(alertController, animated: true, completion: nil)
  }
}
