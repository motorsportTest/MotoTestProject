//
//  ViewController.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {

    enum StoriesFeed: String, CaseIterable{
        case top = "Top"
        case new = "New"
        case best = "Best"
    }
    
    @IBOutlet weak var storiesSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateSegmentControl()
    }
    
    private func configurateSegmentControl(){
        storiesSegmentControl.removeAllSegments()
        for i in 0..<StoriesFeed.allCases.count{
            storiesSegmentControl.insertSegment(withTitle: StoriesFeed.allCases[i].rawValue, at: i, animated: false)
        }
        storiesSegmentControl.selectedSegmentIndex = 0
    }
    
    //MARK: Actions
    
    @IBAction func feedChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }

}

