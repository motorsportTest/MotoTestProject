//
//  File.swift
//  app
//
//  Created by Aleksey on 15.10.2018.
//  Copyright © 2018 Grapheme. All rights reserved.
//

import UIKit

class XIBView: UIView {
    @IBOutlet var contentView:UIView?
    
    var customNameXibFile:String?{get{return nil}}
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let className = customNameXibFile ?? String(describing: type(of: self))
        Bundle.main.loadNibNamed(className , owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
        didLoad()
    }
    
    func didLoad(){
        
    }
    
    
}
