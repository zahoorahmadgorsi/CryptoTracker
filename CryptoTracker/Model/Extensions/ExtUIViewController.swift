//
//  ExtUIViewController.swift
//  CryptoTracker
//
//  Created by iMac on 29/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func ShowAlert(_ strTitle: String,_ strMessage:String,_ btnTitle: String = "Dismiss" ,  btnTapHandler: (()->Swift.Void)? = nil){
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion:btnTapHandler)
    }
    
    
    
}
