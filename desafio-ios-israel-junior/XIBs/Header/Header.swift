//
//  Header.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

class Header: UIView
{
    
    @IBOutlet var contentView:      UIView!
    @IBOutlet weak var image:       UIImageView!
    @IBOutlet weak var viewFooter:  UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    private func commomInit()
    {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupLayout()
    }
    
    private func setupLayout()
    {
        image.contentMode               = .scaleToFill
        
        viewFooter.backgroundColor      = UIColor.white
        viewFooter.layer.cornerRadius   = 12
    }
    
}
