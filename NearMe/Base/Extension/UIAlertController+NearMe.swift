//
//  UIAlertController+NearMe.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/23.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func nm_generalErrorAlert(errorTitle: String = NSLocalizedString("Error Occured", comment: ""), errorMessage: String?) -> UIAlertController {
        return self.nm_generalAlert(title: errorTitle, message: errorMessage ?? "")
    }
    
    /// Returns a UIAlertController with the specified title, message and optional handlers for Done and Cancel actions
    /// - parameter title: Title of the Alert Controller
    /// - parameter message: Alert message to be displayed
    /// - parameter doneActionHandler: Closure to be called when OK(.default) button is tapped. default is nil
    /// - parameter cancelActionHandler: Closure to be called when .cancel action button is tapped. If not nil, a cancel button is added to the Alert with this closure as the handler
    static func nm_generalAlert(title: String, message: String?, doneButtonTitle: String = NSLocalizedString("OK", comment: "OK"), doneActionHandler: (() -> Void)? = nil, cancelActionHandler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        let action = UIAlertAction(title: doneButtonTitle, style: .default) { (_) in
            doneActionHandler?()
        }
        alert.addAction(action)
        
        if let cancelActionHandler = cancelActionHandler {
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (_) in
                cancelActionHandler()
            })
            alert.addAction(cancelAction)
        }
        
        return alert
    }
}
