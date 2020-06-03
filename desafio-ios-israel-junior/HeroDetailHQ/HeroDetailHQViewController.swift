//
//  HeroDetailHQViewController.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit


class HeroDetailHQViewController: UIViewController
{

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var viewDetailHQ: UIView!
    @IBOutlet weak var imageHQ: UIImageView!
    
    var heroHQ: HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ!
    
    // MARK: Setup
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HeroDetailViewController {
            let vc      = segue.destination as? HeroDetailViewController
            vc?.hero    = sender as? HeroDetail
            vc?.heroHQ  = heroHQ
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupLayout()
        showHeroHQ(heroHQ)
    }
    
    private func setupLayout()
    {
        view.backgroundColor = UIColor(white: 0, alpha: 0.50)
        view.isOpaque        = false
        
        viewDetailHQ.layer.cornerRadius = 16
        
        buttonClose.layer.cornerRadius = buttonClose.frame.width/2
        
        imageHQ.contentMode                  = .scaleToFill
        imageHQ.layer.cornerRadius           = 16
        imageHQ.layer.borderWidth            = 2
        imageHQ.layer.borderColor            = MarvelColor.MAINRED.colorMarvel().cgColor
        
        labelTitle.font                      = UIFont(name: "Marvel-BoldItalic", size: 14)
        labelTitle.numberOfLines             = 3
        labelTitle.lineBreakMode             = .byWordWrapping
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.minimumScaleFactor        = 0.5
        
        labelPrice.font                      = UIFont(name: "Marvel-Italic", size: 20)
        labelPrice.numberOfLines             = 1
        labelPrice.textAlignment             = .right
    }
    
    func showHeroHQ(_ hq: HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ)
    {
        imageHQ.image               = hq.image
        labelTitle.text             = hq.title
        labelPrice.text             = String(hq.price[0].price).formatPriceHQ()
    }
    
    
    func displayFatalError()
    {
        
    }
    
    @IBAction func close(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
