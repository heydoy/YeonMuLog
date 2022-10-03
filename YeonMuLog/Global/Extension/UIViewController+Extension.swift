//
//  UIViewController+Extension.swift
//  YeonMuLog
//
//  Created by Doy Kim on 2022/10/03.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, actions: UIAlertAction...) {
        let alertViewController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertViewController.addAction(action)
        }
        self.present(alertViewController, animated: true)
    }
}
