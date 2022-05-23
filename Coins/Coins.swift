//
//  Coins.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 19/5/2565 BE.
//

import Foundation
import SwiftyJSON

class Coins {
    let uuid: String 
    let symbol: String
    let name: String
    let color: String
    let iconUrl: String
    let price: Double
    let listedAt: Int
    let tier: Int
    let change: Double
    let rank: Int
    let lowVolume: Bool
    let coinrankingUrl: String
    
    let websiteUrl: String?
    let description: String?
    let marketCap: Double?
    
    init(data: JSON) {
        self.uuid = data["uuid"].stringValue
        self.symbol = data["symbol"].stringValue
        self.name = data["name"].stringValue
        self.color = data["color"].stringValue
        self.iconUrl = data["iconUrl"].stringValue
        self.price = data["price"].doubleValue
        self.listedAt = data["price"].intValue
        self.tier = data["price"].intValue
        self.change = data["price"].doubleValue
        self.rank = data["price"].intValue
        self.lowVolume = data["price"].boolValue
        self.coinrankingUrl = data["coinrankingUrl"].stringValue
        self.websiteUrl = data["websiteUrl"].string
        self.description = data["description"].string
        self.marketCap = data["marketCap"].double
    }
    
    static func coinsFromJSONArray(_ json:JSON) -> [Coins] {
        var coins = [Coins]()
        for (_,data):(String, JSON) in json {
            coins.append(Coins(data: data))
        }
        return coins
    }
}
