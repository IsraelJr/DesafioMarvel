//
//  UIColor+MarvelHeroes.swift
//  desafio-ios-israel-junior
//
//  Created by Israel Santos Junior on 03/06/20.
//  Copyright © 2020 Israel Santos Junior. All rights reserved.
//

import UIKit


public enum MarvelColor
{
    case MAINRED
    case DISABLED
    
    func colorMarvel() -> UIColor
    {
        switch self {
        case .MAINRED:
            return UIColor(red: 255/255, green: 14/255, blue: 38/255, alpha: 0.4)
            
        case .DISABLED:
            return UIColor.lightGray
            
        }
    }
    
}
