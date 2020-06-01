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
    func showListHeroes(_ listHeroes: [HeroesModels.HeroCell])
    func displayFatalError()
}

class HeroListViewController: UIViewController, HeroListDisplayLogic
{
    
    @IBOutlet weak var tableHeroesList: UITableView!
    
    var interactor: HeroListBusinessLogic?
    
    var heroes: [HeroesModels.HeroCell]?
    
    
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }
    
    private func initializeTable()
    {
        interactor?.interactorRequestListHeroes()
    }
    
    func showListHeroes(_ listHeroes: [HeroesModels.HeroCell])
    {
        heroes = listHeroes
        tableHeroesList.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHero", for: indexPath) as! HeroesTableViewCell
        
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
        print("iasj: selecionado", indexPath.item)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        print("iasj: deselecionado", indexPath.item)
    }
}


