//
//  extendsion.swift
//  RandomAnswer
//
//  Created by Duc'sMacBook on 8/20/20.
//  Copyright © 2020 VSHR. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIButton{
    
    func animated(){
        UIView.animate(withDuration: 0.2,
        animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
