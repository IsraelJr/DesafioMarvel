//
//  HeroListInteractor.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation

protocol HeroListBusinessLogic
{
    func interactorRequestListHeroes()
}

class HeroListInteractor: HeroListBusinessLogic
{
    var presenter: HeroListPresentationLogic?
    
    func interactorRequestListHeroes()
    {
        DispatchQueue.main.async
            {
                HeroListWorker().loadHeroesList(onComplete:
                    { [weak self] (response) in
                        self?.interactorRequestDownloadImageHero(response.data.results)
                        
                }) { (error) in
                    print("iasj: erro na pesquisa", error)
                }
        }
    }
    
    private func interactorRequestDownloadImageHero(_ listHeroes: [HeroModels.ReponseData.InfoHeroes])
    {
        DispatchQueue.main.async
            {
                HeroListWorker().downloadImageHero(listHeroes, onComplete: { [weak self] (response) in
                    self?.presenter?.presenterListHeroes(response)
                    
                }) { (error) in
                    print("iasj: erro 2",error)
                }
        }
    }
}
