//
//  Title.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

protocol TitleProtocol: class
{
    func actionButtonsTitle(button: UIButton)
}

class Title: UIView
{
    
    @IBOutlet var contentView:     UIView!
    @IBOutlet weak var viewTitle:  UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    enum ButtonsTitle
    {
        case BACK
        case NEXT
    }
    
    weak var delegate: TitleProtocol?
    
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

        contentView.backgroundColor = UIColor.clear
        
        viewTitle.backgroundColor   = UIColor.clear
        
        labelTitle.textAlignment    = .center
        labelTitle.font             = UIFont(name: "Marvel-Bold", size: 24)
    }
    
    func changeTitle(to title: String)
    {
        labelTitle.text = title.uppercased()
    }
    
    func hideButtonsNavigation(hide: Bool, button: ButtonsTitle)
    {
        switch button
        {
        case .BACK:
            buttonBack.isHidden = hide
            
        case .NEXT:
            buttonNext.isHidden = hide
        }
    }
    
    @IBAction func actionButtonsNavigation(_ sender: UIButton)
    {
        delegate?.actionButtonsTitle(button: sender)
    }
}
