//
//  ViewController.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

protocol HeroListDisplayLogic: class
{
    func showListHeroes(_ listHeroes: [HeroDetail])
    func displayFatalError()
}

class HeroListViewController: UIViewController, HeroListDisplayLogic
{
    
    @IBOutlet weak var tableHeroesList: UITableView!
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    
    var interactor: HeroListBusinessLogic?
    
    var hero:   HeroDetail?
    var heroes: [HeroDetail]?
    
    
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
        let interactor              = HeroListInteractor()
        let presenter               = HeroListPresenter()
        
        viewController.interactor   = interactor
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HeroDetailViewController {
            let vc      = segue.destination as? HeroDetailViewController
            vc?.hero    = sender as? HeroDetail
            vc?.heroes  = heroes
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSelfs()
        setupLayout()
        initializeTable()
    }
    
    private func setupSelfs()
    {
        tableHeroesList.delegate    = self
        tableHeroesList.dataSource  = self
    }
    
    private func setupLayout()
    {
        tableHeroesList.backgroundColor = UIColor.white
        tableHeroesList.separatorStyle  = .none
        
        indicatorLoading.color          = .red
        
        showLoading(heroes?.count ?? 0 > 0 ? false : true)
    }
    
    private func initializeTable()
    {
        if heroes?.count ?? 0 == 0 { interactor?.interactorRequestListHeroes() }
    }
    
    private func showLoading(_ show: Bool)
    {
        indicatorLoading.isHidden = !show
        if show { indicatorLoading.startAnimating() } else { indicatorLoading.stopAnimating() }
    }
    
    func showListHeroes(_ listHeroes: [HeroDetail])
    {
        heroes = listHeroes
        heroes = heroes!.sorted(by: { $0.name < $1.name })
        tableHeroesList.reloadData()
        showLoading(false)
    }
    
    func displayFatalError()
    {
        
    }
    
}

extension HeroListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return heroes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHero", for: indexPath) as! HeroTableViewCell
        
        if heroes?.count ?? 0 > 0
        {
            cell.prepareCell(image: heroes![indexPath.row].image!, name: heroes![indexPath.row].name!)
        }
        return cell
    }
}


extension HeroListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        hero = HeroDetail(id: heroes?[indexPath.row].id, image:  heroes?[indexPath.row].image, name: heroes?[indexPath.row].name, description: heroes?[indexPath.row].description)
        
        performSegue(withIdentifier: "segueHeroDetail", sender: hero)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        print("iasj: deselecionado", indexPath.item)
    }
}


