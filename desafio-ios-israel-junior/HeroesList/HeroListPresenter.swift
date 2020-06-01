//
//  HeroListPresenter.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation

protocol HeroListPresentationLogic
{
    func presenterListHeroes(_ listHeroes: [HeroesModels.HeroCell])
}

class HeroListPresenter: HeroListPresentationLogic
{
    var viewController: HeroListDisplayLogic?
    
    func presenterListHeroes(_ listHeroes: [HeroesModels.HeroCell])
    {
        viewController?.showListHeroes(listHeroes)
    }
}
