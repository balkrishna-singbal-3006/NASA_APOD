//
//  ActivityIndicatorNotifiable.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

protocol ActivityIndicatorNotifiable where Self: UIViewController {
    var indicator: UIActivityIndicatorView? { get set }
    func addActivityIndicator()
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicatorNotifiable {
  /**
   Creates an activity indicator and adds it to the view.
   */
  func addActivityIndicator() {
    self.indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
      indicator!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
      indicator!.center = view.center
      self.view.addSubview(indicator!)
      self.view.bringSubviewToFront(indicator!)
  }
  
  /**
   Displays an activity indicator.
   */
  func showActivityIndicator() {
      self.indicator?.startAnimating()
  }
  
  /**
   Hides an activity indicator.
   */
  func hideActivityIndicator() {
      self.indicator?.stopAnimating()
  }
}
