//
//  HeroesModel.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

struct HeroModels: Codable
{
    let data: ReponseData
    
    struct ReponseData: Codable
    {
        let results: [InfoHeroes]
        
        struct InfoHeroes: Codable
        {
            let id:          Int
            let name:        String
            let description: String
            let thumbnail:   PhotoHero
            
            struct PhotoHero: Codable
            {
                let path: URL
            }
        }
    }
}

struct HeroDetail
{
    let id:          Int!
    let image:       UIImage!
    let name:        String!
    let description: String?
}
