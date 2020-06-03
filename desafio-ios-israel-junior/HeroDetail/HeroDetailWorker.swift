//
//  HeroDetailHQWorker.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 01/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

typealias responseHQ       = (_ response: HeroDetailHQModels) -> ()
typealias responseListHQs  = (_ response: [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ]) -> ()

class HeroDetailWorker
{
    
    func loadHQ(characterId: Int, onComplete: @escaping (responseHQ), onError: @escaping (ErrorWorker) -> Void) {
        
        let url = urlWithHash(to: characterId)
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(_):
                do {
                    let listHQ = try JSONDecoder().decode(HeroDetailHQModels.self, from: response.data!)
                    onComplete(listHQ)
                    
                } catch  {
                    onError(.invalidJson)
                }
                
            case .failure:
                onError(.noResponse)
            }
            
        })
    }
    
    
    private func urlWithHash(to characterId: Int) -> String
    {
        let publickey       = "8382f4934ed198ce02de5be2600d4455"
        let privatekey      = "6773ddc7b3e40a65917ac0e900719ab15c38aadf"
        let baseUrl         = "https://gateway.marvel.com:443/v1/public/characters/\(characterId)/comics?orderBy=-modified"
        let limit           = 100
        let ts              = heroTimestamp()
        let stringToHash    = "\(String(describing: ts))\(privatekey)\(publickey)"
        let hash            = stringToHash.MarvelHeroMD5()
        let url             = "\(baseUrl)&limit=\(limit)&ts=\(String(describing: ts))&apikey=\(publickey)&hash=\(String(describing: hash!))"
        
        print("iasj: url marvel",url)
        return url
    }
    
    private func heroTimestamp() -> String
    {
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        
        return formatter.string(from: now)
    }
    
    
    func downloadImageHQ(_ listHeroes: [HeroDetailHQModels.ReponseData.InfoHQ], onComplete: @escaping (responseListHQs), onError: @escaping (ErrorWorker) -> Void)
    {
        let proportion = ProportionImage.PORTRAIT_UNCANNY.rawValue
        var returnHero = [HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ]()
        
        for i in 0..<listHeroes.count
        {
            let id          = listHeroes[i].id
            let title       = listHeroes[i].title
            let description = listHeroes[i].description
//            let typePrice   = listHeroes[i].prices[i].type.contains(SaleType.PRINT.rawValue) ? SaleType.PRINT.rawValue : SaleType.DIGITAL.rawValue
//            let price       = [typePrice : listHeroes[i].prices[i].price]
            let request     = "\(listHeroes[i].thumbnail.path)/\(proportion).\(ExtensionImageHero.JPG.rawValue)"
            
            Alamofire.request(request).responseImage { response in
                
                switch response.result {
                case .success(let image):
                    returnHero.append(HeroDetailHQModels.ReponseData.InfoHQ.HeroDetailHQ(id: id, image: image, title: title, description: description, price: listHeroes[i].prices))
                    
                    if i >= listHeroes.count-1
                    {
                        onComplete(returnHero)
                    }
                case .failure(let error):
                    print("downloadImageHero error", error)
                }
            }
        }
        
    }
}
