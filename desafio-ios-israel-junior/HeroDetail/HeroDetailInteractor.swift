//
//  HeroDetailHQInteractor.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation

protocol HeroDetailBusinessLogic
{
    func interactorRequestHQ(_ characterId: Int)
}

class HeroDetailInteractor: HeroDetailBusinessLogic
{
    var presenter: HeroDetailPresentationLogic?
    
    func interactorRequestHQ(_ characterId: Int)
    {
        DispatchQueue.main.async
            {
                HeroDetailWorker().loadHQ(characterId: characterId, onComplete:
                    { [weak self] (response) in
                        self?.interactorRequestDownloadImageHQ(response.data.results)
                        
                }) { (error) in
                    print("iasj: erro na pesquisa", error)
                }
        }
    }
    
    private func interactorRequestDownloadImageHQ(_ listHQs: [HeroDetailHQModels.ReponseData.InfoHQ])
    {
        DispatchQueue.main.async
            {
                HeroDetailWorker().downloadImageHQ(listHQs, onComplete: { [weak self] (response) in
                    self?.presenter?.presenterListHeroHQ(response)
                    
                }) { (error) in
                    print("iasj: erro 2",error)
                }
        }
    }
}
