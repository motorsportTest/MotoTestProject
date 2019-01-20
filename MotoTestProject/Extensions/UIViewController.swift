//
//  UIViewController.swift
//  app
//
//  Created by Aleksey on 27.09.2018.
//  Copyright © 2018 Grapheme. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func alert(text:String){
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Хорошо", style: .default) { action -> Void in
            
        }
        alertController.addAction(cancelActionButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
