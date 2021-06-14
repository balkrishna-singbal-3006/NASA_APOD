//
//  Storyboarded.swift
//  NASA_APOD
//
//  Created by Balkrishna Singbal on 15/06/21.
//

import UIKit

protocol Storyboarded: class {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        
        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
