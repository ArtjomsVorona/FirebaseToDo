//
//  Extension.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 08/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

extension UIViewController {
    func basicAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
