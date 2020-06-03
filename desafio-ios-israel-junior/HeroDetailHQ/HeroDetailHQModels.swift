//
//  HeroDetailHQModels.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit

enum SaleType: String
{
    case PRINT   = "printPrice"
    case DIGITAL = "digitalPurchasePrice"
}

struct HeroDetailHQModels: Codable
{
    let data: ReponseData
    
    struct ReponseData: Codable
    {
        let results: [InfoHQ]
        
        struct InfoHQ: Codable
        {
            let id:          Int
            let title:       String
            let description: String?
            let pageCount:   Int
            let prices:      [Prices]
            let thumbnail:   PhotoHero
            
            struct Prices: Codable
            {
                let type:  String
                let price: Double
            }
            
            struct PhotoHero: Codable
            {
                let path: URL
            }
            
            struct HeroDetailHQ
            {
                let id:          Int!
                let image:       UIImage!
                let title:       String!
                let description: String?
                let price:       [Prices]
            }
        }
        
    }
    
}
