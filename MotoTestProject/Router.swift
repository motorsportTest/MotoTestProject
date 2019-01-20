//
//  Router.swift
//  MotoTestProject
//
//  Created by Aleksey on 20/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit
import SafariServices

class Router{
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController){
        self.viewController=viewController
    }
    
    func openStory(_ story: Story){
        if let storyData = story.storyData{
            if let urlString = storyData.url, let url = URL(string: urlString){
                let safaraVC = SFSafariViewController(url: url)
                viewController?.present(safaraVC, animated: true, completion: nil)
            }else{
                viewController?.alert(text: "The story hasn't url")
            }
        }
    }
}
