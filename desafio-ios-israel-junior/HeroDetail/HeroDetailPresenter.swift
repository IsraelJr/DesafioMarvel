//
//  HeroDetailHQPresenter.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation

protocol HeroDetailPresentationLogic
{
    func presenterListHeroHQ(_ listHeroes: [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ])
}

class HeroDetailPresenter: HeroDetailPresentationLogic
{
    var viewController: HeroDetailDisplayLogic?
    
    func presenterListHeroHQ(_ listHQ: [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ])
    {
        viewController?.showHeroHQ(listHQ)
    }
}
