//
//  HeroDetailViewController.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

protocol HeroDetailDisplayLogic: class
{
    func showHeroHQ(_ hq: [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ])
    func displayFatalError()
}

class HeroDetailViewController: UIViewController, HeroDetailDisplayLogic
{
    
    @IBOutlet weak var viewHeader: Header!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textviewDescription: UITextView!
    @IBOutlet weak var viewTitle: Title!
    @IBOutlet weak var buttonHQ: UIButton!
    @IBOutlet weak var indicatorResearchingHQ: UIActivityIndicatorView!
    
    var hero: HeroDetail!
    var heroes: [HeroDetail]!
    var heroHQ: HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ?
    
    var interactor: HeroDetailBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup()
    {
        let viewController          = self
        let interactor              = HeroDetailInteractor()
        let presenter               = HeroDetailPresenter()
        
        viewController.interactor   = interactor
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HeroListViewController {
            let vc      = segue.destination as? HeroListViewController
            vc?.heroes  = heroes
        }
        else if segue.destination is HeroDetailHQViewController {
            let vc      = segue.destination as? HeroDetailHQViewController
            vc?.heroHQ  = heroHQ
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSelfs()
        setupLayout()
        setupHeroData()
    }
    
    private func setupSelfs()
    {
        viewTitle.delegate = self
    }
    
    
    private func setupLayout()
    {
        viewHeader.contentView.frame = .init(x: 0, y: 0, width: viewHeader.frame.width, height: viewHeader.frame.height)
        viewHeader.image.image = hero.image
        
        viewTitle.backgroundColor   = UIColor.clear
        viewTitle.contentView.frame = .init(x: 0, y: 0, width: viewTitle.frame.width, height: viewTitle.frame.height)
        
        viewTitle.changeTitle(to: NSLocalizedString("titleHeroDetail", tableName: "HeroesMarvelString", bundle: Bundle(for: type(of: self)), value: "", comment: ""))
        viewTitle.hideButtonsNavigation(hide: true, button: .NEXT)
        
        labelName.font                      = UIFont(name: "Marvel-Bold", size: 24)
        labelName.textAlignment             = .left
        labelName.numberOfLines             = 1
        labelName.minimumScaleFactor        = 0.5
        labelName.adjustsFontSizeToFitWidth = true
        
        textviewDescription.isEditable                      = false
        textviewDescription.font                            = UIFont(name: "Marvel-BoldItalic", size: 17)
        textviewDescription.showsHorizontalScrollIndicator  = false
        
        buttonHQ.backgroundColor              = UIColor.white
        buttonHQ.layer.borderColor            = MarvelColor.MAINRED.colorMarvel().cgColor
        buttonHQ.layer.borderWidth            = 1
        buttonHQ.layer.cornerRadius           = 14
        buttonHQ.titleLabel?.font             = UIFont(name: "Marvel-Bold", size: 14)
        buttonHQ.contentHorizontalAlignment   = .center
        buttonHQ.setTitleColor(UIColor.red, for: .normal)
        
        indicatorResearchingHQ.color          = .red
        showLoading(true)
        
    }
    private func setupHeroData()
    {
        labelName.text           = hero.name
        textviewDescription.text = hero.description
        
        interactor?.interactorRequestHQ(hero.id)
    }
    
    private func enabledButtonHQ(_ enabled: Bool)
    {
        buttonHQ.isEnabled          = enabled
        buttonHQ.layer.borderColor  = enabled ? MarvelColor.MAINRED.colorMarvel().cgColor : MarvelColor.DISABLED.colorMarvel().cgColor
        buttonHQ.setTitleColor(enabled ? UIColor.red : MarvelColor.DISABLED.colorMarvel(), for: .normal)
    }
    
    private func showLoading(_ show: Bool)
    {
        enabledButtonHQ(!show)
        indicatorResearchingHQ.isHidden = !show
        if show { indicatorResearchingHQ.startAnimating() } else { indicatorResearchingHQ.stopAnimating() }
    }
    
    
    func showHeroHQ(_ hq: [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ])
    {
        heroHQ = hq[0]
        showLoading(false)
    }
    
    func displayFatalError()
    {
        //
    }
    
    
    
    
    @IBAction func showHQ(_ sender: UIButton)
    {
        performSegue(withIdentifier: "segueHeroHQ", sender: nil)
    }
    
}


extension HeroDetailViewController: TitleProtocol
{
    func actionButtonsTitle(button: UIButton) {
        
        switch button {
        case viewTitle.buttonBack:
            performSegue(withIdentifier: "segueListHero", sender: nil)
            
        default:
            break
        }
    }
    
    
}
