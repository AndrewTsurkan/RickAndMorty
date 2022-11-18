//
//  Model.swift
//  testRick
//
//  Created by Андрей Цуркан on 18.11.2022.
//

import Foundation
import UIKit

enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknow = "unknown"
    
    var text: String {
        switch self{
        case .alive:
          return "ALIVE"
        case .dead:
            return "DEAD"
        case .unknow:
            return "UNKNOWN"
       }
    }
    var backgroundColor: UIColor{
        switch self{
        case.alive:
            return UIColor(red: 199, green: 255, blue: 185)
        case.dead:
            return UIColor(red: 255, green: 232, blue: 224)
        case.unknow:
            return UIColor(red: 238, green: 238, blue: 238)
        }
    }
    var textColor: UIColor{
        switch self{
        case.alive:
            return UIColor(red: 49, green: 159, blue: 22)
        case.dead:
            return UIColor(red:233 , green: 56, blue: 0)
        case.unknow:
            return UIColor(red: 160, green: 160, blue: 160)
        }
    }
}
