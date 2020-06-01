//
//  HeroListNetworkingWorker.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 31/05/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

enum ErrorWorker
{
    case noResponse
    case invalidJson
}

enum ExtensionImageHero: String
{
    case JPEG   = "jpeg"
    case JPG    = "jpg"
    case PNG    = "png"
    case PDF    = "pdf"
}

enum ProportionImage: String
{
    case PORTRAIT_SMALL      = "portrait_small"         //50 X 75px
    case PORTRAIT_MEDIUM     = "portrait_medium"        //100 X 150px
    case PORTRAIT_XLARGE     = "portrait_xlarge"        //150 X 225px
    case PORTRAIT_FANTASTIC  = "portrait_fantastic"     //168 X 252px
    case PORTRAIT_UNCANNY    = "portrait_uncanny"       //300 X 450 px
    case PORTRAIT_INCREDIBLE = "portrait_incredible"    //216 X 324px

}

typealias responseList  = (_ response: HeroesModels) -> ()
typealias responseHero  = (_ response: [HeroesModels.HeroCell]) -> ()

class HeroListWorker
{
    
    func loadHeroesList(onComplete: @escaping (responseList), onError: @escaping (ErrorWorker) -> Void) {
        
        let url    = urlWithHash()
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(_):
                do {
                    let listHeroes = try JSONDecoder().decode(HeroesModels.self, from: response.data!)
                    onComplete(listHeroes)
                } catch  {
                    onError(.invalidJson)
                }
            case .failure:
                onError(.noResponse)
            }
            
        })
    }
    
    
    private func urlWithHash() -> String
    {
        let publickey       = "8382f4934ed198ce02de5be2600d4455"
        let privatekey      = "6773ddc7b3e40a65917ac0e900719ab15c38aadf"
        let baseUrl         = "https://gateway.marvel.com:443/v1/public/characters?"
        let limit           = 100
        let ts              = heroTimestamp()
        let stringToHash    = "\(String(describing: ts))\(privatekey)\(publickey)"
        let hash            = stringToHash.MarvelHeroMD5()
        let url             = "\(baseUrl)limit=\(limit)&ts=\(String(describing: ts))&apikey=\(publickey)&hash=\(String(describing: hash!))"
        
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
    
    
    func downloadImageHero(_ listHeroes: [HeroesModels.ReponseData.InfoHeroes], onComplete: @escaping (responseHero), onError: @escaping (ErrorWorker) -> Void)
    {
        let proportion = ProportionImage.PORTRAIT_UNCANNY.rawValue
        var returnHero = [HeroesModels.HeroCell]()
        
        for i in 0..<listHeroes.count
        {
            let name    = listHeroes[i].name
            let request = "\(listHeroes[i].thumbnail.path)/\(proportion).\(ExtensionImageHero.JPG.rawValue)"
            
            Alamofire.request(request).responseImage { response in
                
                switch response.result {
                case .success(let image):
                    returnHero.append(HeroesModels.HeroCell(name: name, image: image))
                    
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
