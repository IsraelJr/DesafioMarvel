//
//  HeroesTableViewCell.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell
{

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var labelHeroName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupLayout()
    {
        self.backgroundColor            = UIColor.clear
        self.selectionStyle             = .none
        
        viewCard.layer.borderWidth      = 1
        viewCard.layer.borderColor      = MarvelColor.MAINRED.colorMarvel().cgColor
        viewCard.layer.cornerRadius     = 8
        viewCard.layer.shadowRadius     = 4
        viewCard.layer.shadowColor      = UIColor.red.cgColor
        viewCard.layer.shadowOffset     = CGSize(width: 4, height: 4)
        viewCard.layer.shadowOpacity    = 0.24
        
        imageHero.layer.cornerRadius    = 8
        
        labelHeroName.numberOfLines             = 2
        labelHeroName.lineBreakMode             = .byWordWrapping
        labelHeroName.adjustsFontSizeToFitWidth = true
        labelHeroName.minimumScaleFactor        = 0.5
        labelHeroName.font                      = UIFont(name: "Marvel-Bold", size: 17)
    }
    
    func prepareCell(image: UIImage, name: String)
    {
        imageHero.image     = image
        labelHeroName.text  = name
    }

}
