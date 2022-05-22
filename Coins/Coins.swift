//
//  Coins.swift
//  Coins
//
//  Created by Sakaoduean Thichaem on 19/5/2565 BE.
//

import Foundation
import SwiftyJSON

class Coins {
    let uuid: String //"uuid":"Qwsogvtv82FCd",
    let symbol: String //"symbol":"BTC",
    let name: String //"name":"Bitcoin",
    //"color":"#f7931A",
    let iconUrl: String //"iconUrl":"https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
    //"marketCap":"568957332064",
    let price: Double //"price":"29875.799877633384",
    let listedAt: Int //"listedAt":1330214400,
    let tier: Int //"tier":1,
    let change: Double //"change":"2.17",
    let rank: Int //"rank":1,
    /*"sparkline":[
       "29240.4432362238150000000000",
       "29063.4150220082560000000000",
       "28999.8404587813060000000000",
       "29099.9357535773700000000000",
       "29072.9658200976700000000000",
       "29290.7951228533640000000000",
       "29168.8569753216650000000000",
       "29243.0550814980100000000000",
       "29177.7417997131160000000000",
       "28982.7352067724280000000000",
       "28871.2130968870400000000000",
       "28980.0484192529300000000000",
       "28832.6950592464640000000000",
       "29111.2052148548400000000000",
       "29248.9201189842000000000000",
       "29147.0357608056100000000000",
       "29127.1297047400730000000000",
       "29266.1105089062000000000000",
       "29189.1265645474380000000000",
       "29113.4757087119600000000000",
       "28993.1994568460900000000000",
       "29124.7190114905860000000000",
       "29335.3012116669960000000000",
       "29487.6559333621340000000000",
       "29602.3887033723370000000000",
       "29776.5252977119100000000000",
       "29875.7998776333840000000000"
    ],*/
    let lowVolume: Bool //"lowVolume":false,
    let coinrankingUrl: String //"coinrankingUrl":"https://coinranking.com/coin/Qwsogvtv82FCd+bitcoin-btc",
    //"24hVolume":"27877952189",
    //"btcPrice":"1"
    
    init(data: JSON) {
        self.uuid = data["uuid"].stringValue
        self.symbol = data["symbol"].stringValue
        self.name = data["name"].stringValue
        //
        self.iconUrl = data["iconUrl"].stringValue
        //
        self.price = data["price"].doubleValue
        self.listedAt = data["price"].intValue
        self.tier = data["price"].intValue
        self.change = data["price"].doubleValue
        self.rank = data["price"].intValue
        //
        self.lowVolume = data["price"].boolValue
        self.coinrankingUrl = data["coinrankingUrl"].stringValue
        //
        //
    }
    
    static func coinsFromJSONArray(_ json:JSON) -> [Coins] {
        var coins = [Coins]()
        for (_,data):(String, JSON) in json {
            coins.append(Coins(data: data))
        }
        return coins
    }
}
